CREATE TABLE IF NOT EXISTS routine (
    id UUID PRIMARY KEY NOT NULL,
    name VARCHAR(256) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS exercise (
    id UUID PRIMARY KEY NOT NULL,
    name VARCHAR(256) NOT NULL, 
    link VARCHAR(512) DEFAULT '',
    description VARCHAR(2560) DEFAULT '',
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS exercise_record (
    id UUID PRIMARY KEY NOT NULL,
    exercise_id UUID NOT NULL,
    routine_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    reps INTEGER[] NOT NULL,
    weight Float NOT NULL,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (routine_id) REFERENCES routine(id)
    );

CREATE TABLE IF NOT EXISTS routine_exercise (
    exercise_id UUID NOT NULL,
    routine_id UUID NOT NULL,
    day VARCHAR(256) NOT NULL, 
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY (exercise_id, routine_id, day),
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (routine_id) REFERENCES routine(id)
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
 
CREATE TABLE IF NOT EXISTS training (
    id UUID PRIMARY KEY NOT NULL,
    time_start TIMESTAMPTZ NOT NULL,
    time_end TIMESTAMPTZ,
    routine_id UUID NOT NULL,
    day VARCHAR(256) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (routine_id) REFERENCES routine(id)
    );
