## Brainstorming

keep track of Personal Record

Workout recommendations 
    - Alternative ways to do a workout
        - Ex: Do Squat with dumbells instead of barbell
Videos of good form
    - Link to youtube video

Calories intake
    - Calories per meal
    - Calories per food
    - Daily calorie Tracker

Gym Recommendations
    - Gym Reviews
        - Cleanliness   
        - Does it have enough machines
        - Busy Times

Equipment Recommendations

Weight Progress

BMI Tracker

Routine Recommendations Guides

Step Tracker

Timer for breaks

Allow training session Breaks

Apple watch compatibility
    - Maybe for break timer
    - And set reps

## Priorities
- Active Session Screen

    - Timer for overall time of exercise
    - Timer for time of current set
    - Timer for time of break
    - We'll need to have a state
        - Init
            - Show start button
            - Previous Weight and Reps
        - Exercising
            - Show timer for set
            - Show Done Button
                - Dont allow done until weight and reps are filled out
        - Breaking
            - Show all the sets done so far with times
            - Show timer for break 
                - Maybe have the timer set at a certain time e.g.
                    - 01:00 -> 00:30 -> 00:00 -> - 00:30
        - Done

- Statistics
    - Day Statistics
        - Average time taken to complete day
        - Average time between exercises
        - Average time taken to complete an exercise 

- Allow training sessions to have breaks in between
    - So a pause/stop function
    - We can do this two ways: 
        1) Create a new table which holds only breaks and is tied to a training session, each break in and break out will be its own row with datetime
        2) create a breakins and breakouts column which holds TIMEDATE[]. 
    - If we want to also track how long an exercise is we need to do a similar thing as the training_session where we have an exercise_session.
    - This would enable us to keep track of breaks in an exercise_session, how long it took to complete an exercise.
    - For this we would need a new table which tracks an exercise_session and which set were on:
        exercise_session
            - start_time
            - end_time
    - Actually maybe what we really want is a set tracker
        - We can tie the set to the training_session as well as the exercise
        - We'll call it set_session:
            - training_session_id
            - exercise_id
            - start_time
            - end_time
            - reps: Int[]
            - weight: Int[]
        - With this we can probably get rid of exercise_routine, since we are recording the weight and reps.
        - Actually we can just use the exercise_record as the set_session, but what if we want to know how long it took us to do one single set of reps?
        - We would have to create a set_record. Which would mean that we have the following analogues:
            - training_session -> 1 day of a routine
            - exercise_record -> 1 exercise of a day of a routine
            - set_record -> 1 set of an exercise of a routine
        - To keep the pattern lets rename set_record to set_session and exercise_record to exercise_session
        - This means we can remove the reps and weight from exercise_session, since we will be tying the set_session to it
        - So the set_session will look like this:
        set_session
            - exercise_session_id: UUID
            - start_time: TIMESTAMPTZ
            - end_time: TIMESTAMPTZ
            - number_of_reps: INTEGER
            - weight: INTEGER
        - We've now reorganized the tables, so now lets write some queries for the operations that will be common in the app

        - Get routine exercises along with the days they correspond to:
        SELECT * FROM (SELECT * FROM routine_exercise
        WHERE routine_id = R as routine_exercise_mapping
        LEFT JOIN exercise
        ON routine_exercise_mapping.exercise_id = exercise.id) as exercise 
        LEFT JOIN day
        ON day.id = exercise.day_id;

        - Get all exercise sessions with all sets with exercise_id = e1, routine_id = r2, day = d3
        SELECT * FROM (SELECT * FROM routine_exercise
        WHERE routine_id = r2 AND exercise_id = d1 AND day = d3
        LEFT JOIN exercise_session
        ON exercise_session.routine_exercise_id = routine_exercise.id) as exercise_sessions
        LEFT JOIN set_session
        ON exercise_session.id = set_session.exercise_session_id as exercise_session_sets;
            
            - Can we paginate this? This doesn't seem like it'll be an issue for now.
        

- Show training sessions stats at the end of the session
    - How long did it take to complete one exercise?
    - Time between exercises
    - Analytics for how much better you did this time from the last exercise.
        - eg you did 2.5 lbs more this time, took 20 sec less break
        - green for improvement, red for unimprovements
- Track Number of Routines completed DONE
    - We can do this by checking if all days have been completed when we turn from the last day in the cycle to the first
    - If we have not we can prompt the user to force turn the routine

- Keeping track of what day we are on for what routine DONE
    - We can save the day we are on and keep a seperate table for it
        - We'll do this option as it makes things more flexible
        - Actually maybe we wont need a seperate table for it but we can add a new field to training_session, called routine_number
        - routine_number will be the number of routines we are on, so if we've done 4 routines, we'll be on routine_number 5. It will serve as a count, and also an id of what routine we're on
        - This will enable us to see what routine number a training session is in and also what days were completed in the routine.
        - This also allows for us to track what days are completed in the routine and what days are left, as well as when to turn and we can also forcefully turn the routine by setting the routine number to the next number. 
            - This brings up the idea of "turning", How do we know what routine number we are on or more importantly when we've manually turned (this occurs when the user skips a day). We would have to keep an extra table which keeps track of the routine number for a routine. This will fix the issue of keeping track of what routine number a user is on, it will also make it faster to see how many routines a user has done.
            - This new table looks like this:
                routine_number_tracker
                - routine_id: UUID
                - routine_number: Int
                - last_turned: Date
            - This enables us to check what session we are currently on, then use that to check what days have been completed for that routine_number.
            - It also provides us with the ability to see what days have been missed for what routine_number
            - Actually since this table would map 1-1 with the routine table, we can just add the column onto the routine table. Since every routine will only have 1 routine_number.
    - We can also look for the last session with the routine id and see what day it was
    - How do we deal with when the routine is switched around?
        - I think the best way to do it is to just keep track of the original last day, then assign it to that
        - This makes me think maybe we should actually assign id's to the days
            - The new Schema would look like this:
            - Day
                - Routine_ID: The routine it belongs to
                - order: The order it appears in, in the routine
                - Name: Name of the day
        - Now that we've added a current_routine_number, we can use this to check what is the next day in the routine easily by getting all the training sessions with the routine_number of the current_routine_number, then get the training_session which has the greatest order. The next order would be the:
        (max(training_session.day_order) % COUNT(day where routine_id matches)) + 1

## Users

If we want to have users we need to decide what is user level, what users can have as their own,
what is public, meaning what gets shared between users.

### Thoughts

User Level
    - Routines
        - Option to make them public?
    - Sessions
Public
    - Exercises
    - Muscle Groups
- Making things public means we need to have a reliable source for them, if we make them public and the names of them unique then users wont be able to have the same flexibility they would have with keeping them private.
Ideally we want the best of both worlds,with the following scenarios working
    - a user looks up an exercise, and gets a reliable one
    - a user looks up an exercise, can't find it, can create their own
    - a user looks up an exercise, finds it but would like to modify it
To achieve this we can add 2 new fields to the exercise table: is_official and creator_user_id.

Drawbacks to this would be we would need to store a "true" copy of the exercise, which would enable the user to keep their copy of the exercise, and the official exercise to be unchanged.

Another drawback would be we would have to keep a reference to the "official" copy of the exercise. With this double saving, if we wanted to take advantage of the user using the official one and thus saving us space, we would need to switch the reference of the exercise once they edited it to their new edited one. Which would involve updating routine_exercise.
We would have to update all routine_exercise with the user_id and exercise_id of the old exercise to the exercise_id of the new one.

The new exercise table would include

is_official BOOL
creator_user_id UUID

How will this work?

On exercise search we will only search exercises where the creator ID matches and ones where is_official is true.

When a user tries to edit an exercise:

First check if the exercise is theirs, if creator_id = their id.

if it does then we can directly edit the one we have the reference to.

if not then we must:
    - Create a copy of the official exercise with the creator_id being the users id, and is_official being false. Make sure to also copy over the references of the muscle groups.
    - Update the reference of all the exercise_routines with user_id == creator_id and exercise_id = old_exercise_id to reference the newly credated copy







    






