-- Create Routine

INSERT INTO routine (id, name, current_routine_number)
VALUES ('c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 'Routine 1', 1);

-- Create Exercise

INSERT INTO exercise (id, name)
VALUES ('781ee5b9-84cb-4751-9b43-cc6258e1e967', 'Bicep Curls');

INSERT INTO exercise (id, name)
VALUES ('96afe0bc-8288-44cd-b372-c39f126b0717', 'Tricep Extensions');

INSERT INTO exercise (id, name)
VALUES ('f11223c7-852c-421a-8b8b-f37e7ad4d09b', 'Dumbell Chest Press');

INSERT INTO exercise (id, name)
VALUES ('0422daf6-71c1-4563-96c0-54f9a1c1bf72', 'Military Press');

INSERT INTO exercise (id, name)
VALUES ('fe99d8b6-691a-4bb4-9ec9-7f59d938345e', 'Dumbell Squats');

INSERT INTO exercise (id, name)
VALUES ('8ea05b9e-2cc1-458d-944a-ff11a4bd436e', 'Front/Side Raise');

-- Create Day

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('4052d78b-d34f-499c-8311-feb1b0e0a416', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 1, 'Day 1: Arms');

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('f7873c68-bc26-4010-bd85-9b28a3aeaddc','c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 2, 'Day 2: Chest');

INSERT INTO day (id, routine_id, day_order, name)
VALUES ('ad01cd5e-910f-4c76-ab5b-92bc227bae53', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', 3, 'Day 3: Legs');

-- Create routine_exercise (The pairing between routine, exercise and day)

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

-- Create training_session

INSERT INTO training_session (id, time_start, time_end, routine_id, day_id, routine_number)
VALUES ('4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp, current_timestamp + (45.6 * interval '1 minute'), 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e','4052d78b-d34f-499c-8311-feb1b0e0a416', 1);

-- Create exercise_session

INSERT INTO exercise_session (id, routine_exercise_id, training_session_id, start_time, end_time)
VALUES ('d730209b-a944-46f3-88c4-c622b02e2b8b', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', '4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (4.7 * interval '1 minute'));

INSERT INTO exercise_session (id, routine_exercise_id, start_time, end_time)
VALUES ('eac8502f-e304-41f6-8cb0-d083095f951c', 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e', '4052d78b-d34f-499c-8311-feb1b0e0a416', current_timestamp + (5.2 * interval '1 minute'), current_timestamp + ((9.8 * interval '1 minute'));

-- Create set_session

INSERT INTO set_session (id, exercise_session_id, start_time, end_time, number_of_reps, weight)
VALUES ('569424c5-5b2e-4655-a641-3359bbf198ab', 'd730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (0.3 * interval '1 minute'), current_timestamp + (2 * interval '1 minute'), 12, 20);

INSERT INTO set_session (id, exercise_session_id, start_time, end_time, number_of_reps, weight)
VALUES ('55ca6661-33b0-4070-9529-eed3d7a5dfc2', 'd730209b-a944-46f3-88c4-c622b02e2b8b', current_timestamp + (2.1 * interval '1 minute'), current_timestamp + (4.6 * interval '1 minute'), 10, 20);

INSERT INTO set_session (id, exercise_session_id, start_time, end_time, number_of_reps, weight)
VALUES ('421c155f-8e8a-40b6-a502-d32850e2494d', 'eac8502f-e304-41f6-8cb0-d083095f951c', current_timestamp + (5.2 * interval '1 minute'), current_timestamp + (7.1 * interval '1 minute'), 8, 12);

INSERT INTO set_session (id, exercise_session_id, start_time, end_time, number_of_reps, weight)
VALUES ('1b527f71-fb37-4897-827d-9241cce126ac', 'eac8502f-e304-41f6-8cb0-d083095f951c', current_timestamp + (7.2 * interval '1 minute'), current_timestamp + (9.8 * interval '1 minute'), 8, 12)



