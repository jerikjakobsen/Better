# Server Routes

## Needed Routes

### Get Routes
 
- Routine Home Page 
    - Given a routine ID
    - Return
        - Days along with what days are done for this routine cycle
- Day Details Page 
    - Given a day_id and routine_id
    - Return
        - Average Time to Complete Day
        - Average Time Between Exercises
        - Muscle Groups trained for all exercises in the day
        - All Exercises

- Day Session Page
    - Given A day_id and routine_id
    - Return
        - All Exercises
        - For each exercise, the last 4 sessions for the exercise (date, weight, reps, time to complete, notes, average break)

- Exercise Details Page
    - Given an exercise ID
    - Return
        - Name
        - a list of sessions (date, weight, reps, time to complete, notes, average break)
        - average time to complete
        - average time per set
        - average time between sets
        - description
        - link
        - muscle groups

How should we organize the backend? 

- /routes
    - /routine
        - page
        - /queries -> Should have a functions that return a response from the database
        - index
- /database
    - index  
