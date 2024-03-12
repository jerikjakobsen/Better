CREATE TABLE IF NOT EXISTS routine (
    id UUID PRIMARY KEY NOT NULL,
    name VARCHAR(256) NOT NULL,
    current_routine_number INTEGER NOT NULL DEFAULT 1,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS exercise (
    id UUID PRIMARY KEY NOT NULL,
    name VARCHAR(256) NOT NULL, 
    link VARCHAR(512) DEFAULT '',
    description VARCHAR(2560) DEFAULT '',
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS day (
    id UUID PRIMARY KEY NOT NULL,
    routine_id UUID NOT NULL,
    day_order INTEGER NOT NULL,
    name VARCHAR(256) NOT NULL,
    FOREIGN KEY (routine_id) REFERENCES routine(id)
    ); 

CREATE TABLE IF NOT EXISTS routine_exercise (
    id UUID PRIMARY KEY NOT NULL,
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
    id UUID PRIMARY KEY NOT NULL,
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
 
CREATE TABLE IF NOT EXISTS exercise_session (
    id UUID PRIMARY KEY NOT NULL,
    routine_exercise_id UUID NOT NULL,
    start_time TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    end_time TIMESTAMPTZ,
    FOREIGN KEY (routine_exercise_id) REFERENCES routine_exercise(id)
    );

CREATE TABLE IF NOT EXISTS set_session (
    id UUID PRIMARY KEY NOT NULL,
    exercise_session_id UUID NOT NULL,
    start_time TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    end_time TIMESTAMPTZ,
    number_of_reps INTEGER NOT NULL DEFAULT 0,
    weight INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (exercise_session_id) REFERENCES exercise_session(id)
    );

CREATE TABLE IF NOT EXISTS training_session (
    id UUID PRIMARY KEY NOT NULL,
    time_start TIMESTAMPTZ NOT NULL,
    time_end TIMESTAMPTZ,
    routine_id UUID NOT NULL,
    day_id UUID NOT NULL,
    routine_number INTEGER NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (routine_id) REFERENCES routine(id),
    FOREIGN KEY (day_id) REFERENCES day(id)
    );

