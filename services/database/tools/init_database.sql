CREATE DATABASE IF NOT EXISTS transcendance;
\c transcendance;

--USERS
CREATE TABLE users IF NOT EXISTS (
    id_user bigint GENERATED IDENTITY AS ALWAYS PRIMARY KEY,
    username VARCHAR,
    avatar VARCHAR
);

CREATE TABLE user_to_user IF NOT EXISTS (
    id_user_src bigint REFERENCES users,
    id_user_dst bigint REFERENCES users,
    PRIMARY KEY (id_user_src, id_user_dst)
);

--CONVERSATIONS

CREATE TABLE conversations IF NOT EXISTS (
    id_conversation bigint GENERATED IDENTITY AS ALWAYS PRIMARY KEY,
    is_channel bigint REFERENCES channels,
    is_discussion bigint REFERENCES discussions,
    CHECK (is_channel IS NOT NULL + is_discussion IS NOT NULL = 1)
);

CREATE TABLE conversation_messages IF NOT EXISTS (
    id_msg bigint GENERATED IDENTITY AS ALWAYS PRIMARY KEY,
    id_conversation bigint REFERENCES conversations,
    id_sender bigint REFERENCES users,
    content varchar
);

-- DISCUSSIONS

CREATE TABLE discussions IF NOT EXISTS (
    id_discussion bigint GENERATED IDENTITY AS ALWAYS PRIMARY KEY,
    id_user_left bigint NOT NULL REFERENCES users,
    id_user_right bigint NOT NULL REFERENCES users,
    UNIQUE(id_user_left, id_user_right),
    UNIQUE(id_user_right, id_user_left),

    FOREIGN KEY (id_discussion) REFERENCES conversations(is_discussion);
);
ALTER TABLE conversations ADD CONSTRAINT fk_conversation_is_discussion FOREIGN KEY (is_discussion) REFERENCES discussions;

-- CHANNELS

CREATE TABLE channels IF NOT EXISTS (
    id_channel bigint GENERATED IDENTITY AS ALWAYS PRIMARY KEY,
    id_owner bigint NOT NULL REFERENCES users,
    name VARCHAR,
    password VARCHAR
);
ALTER TABLE conversations ADD CONSTRAINT fk_conversation_is_channel FOREIGN KEY (is_channel) REFERENCES channels;

CREATE TABLE channel_users IF NOT EXISTS (
    id_channel bigint REFERENCES channels,
    id_user bigint REFERENCES users,
    PRIMARY KEY (id_channel, id_user),
    
    is_moderator boolean DEFAULT FALSE,
    ban_time timestamptz,
    mute_time timestamptz
);
ALTER TABLE channels ADD CONSTRAINT fk_channel_owner FOREIGN KEY (id_channel, id_owner) REFERENCES channel_users;