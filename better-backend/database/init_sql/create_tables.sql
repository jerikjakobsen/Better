DROP TABLE IF EXISTS set_session;
DROP TABLE IF EXISTS note;
DROP TABLE IF EXISTS exercise_session;
DROP TABLE IF EXISTS training_session;
DROP TABLE IF EXISTS exercise_muscle_group;
DROP TABLE IF EXISTS muscle_group;
DROP TABLE IF EXISTS routine_exercise;
DROP TABLE IF EXISTS exercise;
DROP TABLE IF EXISTS day;
DROP TABLE IF EXISTS routine;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    email VARCHAR(256) NOT NULL,
    hash_pass VARCHAR(256) NOT NULL,
    salt VARCHAR(256) NOT NULL
    );

CREATE TABLE IF NOT EXISTS routine (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(256) NOT NULL,
    current_routine_number INTEGER NOT NULL DEFAULT 1,
    creator_user_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (creator_user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS exercise (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(256) NOT NULL, 
    link VARCHAR(512) DEFAULT '',
    description VARCHAR(2560) DEFAULT '',
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    creator_user_id UUID DEFAULT NULL,
    is_official BOOLEAN DEFAULT false,
    FOREIGN KEY (creator_user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS day (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    routine_id UUID NOT NULL,
    day_order INTEGER NOT NULL,
    name VARCHAR(256) NOT NULL,
    FOREIGN KEY (routine_id) REFERENCES routine(id)
    ); 

CREATE TABLE IF NOT EXISTS routine_exercise (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    exercise_id UUID NOT NULL,
    routine_id UUID NOT NULL,
    day_id UUID NOT NULL, 
    break_time INTEGER NOT NULL DEFAULT 0,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (routine_id) REFERENCES routine(id),
    FOREIGN KEY (day_id) REFERENCES day(id)
    );

CREATE TABLE IF NOT EXISTS muscle_group (
    name UUID NOT NULL UNIQUE,
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS exercise_muscle_group (
    exercise_id UUID NOT NULL,
    muscle_group_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id),
    PRIMARY KEY (exercise_id, muscle_group_id)
    );
 
CREATE TABLE IF NOT EXISTS training_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    time_start TIMESTAMPTZ NOT NULL,
    time_end TIMESTAMPTZ,
    routine_id UUID NOT NULL,
    day_id UUID NOT NULL,
    routine_number INTEGER NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (routine_id) REFERENCES routine(id),
    FOREIGN KEY (day_id) REFERENCES day(id)
    );

CREATE TABLE IF NOT EXISTS exercise_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    routine_exercise_id UUID NOT NULL,
    training_session_id UUID NOT NULL,
    start_time TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    end_time TIMESTAMPTZ,
    FOREIGN KEY (routine_exercise_id) REFERENCES routine_exercise(id),
    FOREIGN KEY (training_session_id) REFERENCES training_session(id)
    );

CREATE TABLE IF NOT EXISTS set_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    exercise_session_id UUID NOT NULL,
    start_time TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    end_time TIMESTAMPTZ,
    number_of_reps INTEGER NOT NULL DEFAULT 0,
    weight INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (exercise_session_id) REFERENCES exercise_session(id)
    );

CREATE TABLE IF NOT EXISTS note (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    content VARCHAR(4096) NOT NULL,
    exercise_session_id UUID NOT NULL,
    FOREIGN KEY (exercise_session_id) REFERENCES exercise_session(id)
    );

