-- Create User

INSERT INTO users (id, email, hash_pass, salt)
VALUES ('a8ce98b8-c0a9-4b5a-a605-377e159c320a', 'john@gmail.com', '123456789abcdefghijklmnop', 'salty-saltiness');

INSERT INTO users (id, email, hash_pass, salt)
VALUES ('f2ac4d6c-dc6b-42a2-a373-dc566ec2b44a', 'ngan@gmail.com', ' sadasdahudiuhunbui', 'saltypospd9');

-- Create Routine

INSERT INTO routine (id, name, current_routine_number, creator_user_id)
VALUES ('c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'Routine 1', 2, 'a8ce98b8-c0a9-4b5a-a605-377e159c320a');

INSERT INTO routine (id, name, current_routine_number, creator_user_id)
VALUES ('c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', 'Ngans Routine', 1, 'f2ac4d6c-dc6b-42a2-a373-dc566ec2b44a');

-- Create Exercise

-- User 1 Exercises
INSERT INTO exercise (id, name, is_official)
VALUES ('781ee5b9-84cb-4751-9b43-cc6258e1e967', 'Bicep Curls', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('96afe0bc-8288-44cd-b372-c39f126b0717', 'Tricep Extensions', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('f11223c7-852c-421a-8b8b-f37e7ad4d09b', 'Dumbell Chest Press', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('0422daf6-71c1-4563-96c0-54f9a1c1bf72', 'Military Press', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('fe99d8b6-691a-4bb4-9ec9-7f59d938345e', 'Dumbell Squats', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('8ea05b9e-2cc1-458d-944a-ff11a4bd436e', 'Front/Side Raise', true);

-- User 2 Exercises
INSERT INTO exercise (id, name, is_official)
VALUES ('181ee5b9-84cb-4751-9b43-cc6258e1e967', 'Pull Ups', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('36afe0bc-8288-44cd-b372-c39f126b0717', 'Sit Ups', true);

INSERT INTO exercise (id, name, is_official)
VALUES ('111223c7-852c-421a-8b8b-f37e7ad4d09b', 'Bent Over Row', true);

-- Create Muscle Groups

INSERT INTO muscle_group (name, id)
VALUES ('Biceps', '5cda10a3-7a75-4210-b31f-99eff9a2975e');

INSERT INTO muscle_group (name, id)
VALUES ('Triceps', 'c00557c1-b7ed-44b4-a879-2ae836c7fe5b');

INSERT INTO muscle_group (name, id)
VALUES ('Hamstrings', '78d6b0b9-5247-4006-b6d1-7faf6475bbea');

INSERT INTO muscle_group (name, id)
VALUES ('Quadriceps', 'd0fdc293-75fe-4894-8f32-ab1906e9e89c');

INSERT INTO muscle_group (name, id)
VALUES ('Pectorals', '824b90e5-c567-47a9-a85f-30ddee493e19');

INSERT INTO muscle_group (name, id)
VALUES ('Deltoids', '24fb8527-56fc-4cd4-8559-dc9d30c8f9dd');

-- Create muscle_group_exercise connections

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('781ee5b9-84cb-4751-9b43-cc6258e1e967', '5cda10a3-7a75-4210-b31f-99eff9a2975e');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('96afe0bc-8288-44cd-b372-c39f126b0717', 'c00557c1-b7ed-44b4-a879-2ae836c7fe5b');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('f11223c7-852c-421a-8b8b-f37e7ad4d09b', '824b90e5-c567-47a9-a85f-30ddee493e19');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('f11223c7-852c-421a-8b8b-f37e7ad4d09b', '24fb8527-56fc-4cd4-8559-dc9d30c8f9dd');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('8ea05b9e-2cc1-458d-944a-ff11a4bd436e', '78d6b0b9-5247-4006-b6d1-7faf6475bbea');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('8ea05b9e-2cc1-458d-944a-ff11a4bd436e', 'd0fdc293-75fe-4894-8f32-ab1906e9e89c');

INSERT INTO exercise_muscle_group (exercise_id, muscle_group_id)
VALUES ('181ee5b9-84cb-4751-9b43-cc6258e1e967', '824b90e5-c567-47a9-a85f-30ddee493e19');

-- Create Day

-- User 1 Days
INSERT INTO day (id, routine_id, day_order, name)
VALUES ('4052d78b-d34f-499c-8311-feb1b0e0a416', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 1, 'Day 1: Arms');

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('f7873c68-bc26-4010-bd85-9b28a3aeaddc','c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 2, 'Day 2: Chest');

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('ad01cd5e-910f-4c76-ab5b-92bc227bae53', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 3, 'Day 3: Legs');

-- User 2 Days
INSERT INTO day (id, routine_id, day_order, name)
VALUES ('7052d78b-d34f-499c-8311-feb1b0e0a416', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', 1, 'Arms and Legs');

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('17873c68-bc26-4010-bd85-9b28a3aeaddc', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', 2, 'Chest and Abs');

-- Create routine_exercise (The pairing between routine, exercise and day)
-- User 1 pairings
INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('9bbf396e-73f2-4373-9924-0b9e04f82962', '781ee5b9-84cb-4751-9b43-cc6258e1e967', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', '4052d78b-d34f-499c-8311-feb1b0e0a416');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('cd04c208-c1bb-4a98-83c8-fcfd4e24cbe5', '96afe0bc-8288-44cd-b372-c39f126b0717', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', '4052d78b-d34f-499c-8311-feb1b0e0a416');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('435500bd-2439-4b86-863e-b8fc8e355a91', 'f11223c7-852c-421a-8b8b-f37e7ad4d09b', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'f7873c68-bc26-4010-bd85-9b28a3aeaddc');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('27969e4a-6cf1-46a2-ac5c-7efe2bc78878', '0422daf6-71c1-4563-96c0-54f9a1c1bf72', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'f7873c68-bc26-4010-bd85-9b28a3aeaddc');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('a93cf7c2-83fa-4d79-a23e-9dba383cd4c3', 'fe99d8b6-691a-4bb4-9ec9-7f59d938345e', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'ad01cd5e-910f-4c76-ab5b-92bc227bae53');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('80f0fd2e-d1f1-4e43-bc82-04a02618ee44', '8ea05b9e-2cc1-458d-944a-ff11a4bd436e', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'ad01cd5e-910f-4c76-ab5b-92bc227bae53');

-- User 2 Pairings
INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('2bbf396e-73f2-4373-9924-0b9e04f82962', '781ee5b9-84cb-4751-9b43-cc6258e1e967', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '7052d78b-d34f-499c-8311-feb1b0e0a416');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('cd04c208-11bb-4a98-83c8-fcfd4e24cbe5', '96afe0bc-8288-44cd-b372-c39f126b0717', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '7052d78b-d34f-499c-8311-feb1b0e0a416');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('435500bd-8439-4b86-863e-b8fc8e355a91', '181ee5b9-84cb-4751-9b43-cc6258e1e967', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '7052d78b-d34f-499c-8311-feb1b0e0a416');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('27969e4a-9cf1-46a2-ac5c-7efe2bc78878', '111223c7-852c-421a-8b8b-f37e7ad4d09b', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '17873c68-bc26-4010-bd85-9b28a3aeaddc');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('a93cf7c2-23fa-4d79-a23e-9dba383cd4c3', '0422daf6-71c1-4563-96c0-54f9a1c1bf72', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '17873c68-bc26-4010-bd85-9b28a3aeaddc');

INSERT INTO routine_exercise (id, exercise_id, routine_id, day_id)
VALUES ('80f0fd2e-b1f1-4e43-bc82-04a02618ee44', '36afe0bc-8288-44cd-b372-c39f126b0717', 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e', '17873c68-bc26-4010-bd85-9b28a3aeaddc');

-- Create training_session

INSERT INTO training_session (id, time_start, time_end, routine_id, day_id, routine_number)
VALUES ('4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp, current_timestamp + (45.6 * interval '1 minute'), 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e','4052d78b-d34f-499c-8311-feb1b0e0a416', 2);

INSERT INTO training_session (id, time_start, time_end, routine_id, day_id, routine_number)
VALUES ('4052d78d-d34f-499c-8311-feb1b0e0a416', current_timestamp, current_timestamp + (45.6 * interval '1 minute'), 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e','4052d78b-d34f-499c-8311-feb1b0e0a416', 1);

-- Create exercise_session

INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, time_start, time_end)
VALUES ('d730209b-a944-46f3-88c4-c622b02e2b8b', '9bbf396e-73f2-4373-9924-0b9e04f82962', '4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (4.7 * interval '1 minute'));

INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, time_start, time_end)
VALUES ('eac8502f-e304-41f6-8cb0-d083095f951c', 'cd04c208-c1bb-4a98-83c8-fcfd4e24cbe5', '4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp + (5.2 * interval '1 minute'), current_timestamp + (9.8 * interval '1 minute'));



INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, time_start, time_end)
VALUES ('a730209b-a944-46f3-88c4-c622b02e2b8b', '9bbf396e-73f2-4373-9924-0b9e04f82962', '4052d78d-d34f-499c-8311-feb1b0e0a416', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (4.7 * interval '1 minute'));

INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, time_start, time_end)
VALUES ('b730209b-a944-46f3-88c4-c622b02e2b8b', 'cd04c208-c1bb-4a98-83c8-fcfd4e24cbe5', '4052d78d-d34f-499c-8311-feb1b0e0a416', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (4.7 * interval '1 minute'));

INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, time_start, time_end)
VALUES ('c730209b-a944-46f3-88c4-c622b02e2b8b', '435500bd-2439-4b86-863e-b8fc8e355a91', '4052d78d-d34f-499c-8311-feb1b0e0a416', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (4.7 * interval '1 minute'));

-- Create set_session

INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('569424c5-5b2e-4655-a641-3359bbf198ab', 'd730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (2 * interval '1 minute'), 12, 20);

INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('55ca6661-33b0-4070-9529-eed3d7a5dfc2', 'd730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (2.1 * interval '1 minute'), current_timestamp + (4.6 * interval '1 minute'), 10, 20);

INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('421c155f-8e8a-40b6-a502-d32850e2494d', 'eac8502f-e304-41f6-8cb0-d083095f951c', current_timestamp + (5.2 * interval '1 minute'), current_timestamp + (7.1 * interval '1 minute'), 8, 12);

INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('1b527f71-fb37-4897-827d-9241cce126ac', 'eac8502f-e304-41f6-8cb0-d083095f951c', current_timestamp + (7.2 * interval '1 minute'), current_timestamp + (9.8 * interval '1 minute'), 8, 12);


INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('669424c5-5b2e-4655-a641-3359bbf198ab', 'c730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (2 * interval '1 minute'), 12, 20);

INSERT INTO set_session (id, exercise_session_id, time_start, time_end, number_of_reps, weight)
VALUES ('769424c5-5b2e-4655-a641-3359bbf198ab', 'c730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (2.3 * interval '1 minute'), current_timestamp + (4.8 * interval '1 minute'), 10, 18);



