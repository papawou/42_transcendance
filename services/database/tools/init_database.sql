--USERS
CREATE TABLE IF NOT EXISTS users  (
    id_user bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR,
    avatar VARCHAR
);

CREATE TABLE IF NOT EXISTS user_to_user  (
    id_user_src bigint REFERENCES users,
    id_user_dst bigint REFERENCES users,
    PRIMARY KEY (id_user_src, id_user_dst)
);


-- DISCUSSIONS

CREATE TABLE IF NOT EXISTS discussions  (
    id_discussion bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user_left bigint NOT NULL REFERENCES users,
    id_user_right bigint NOT NULL REFERENCES users,
    UNIQUE(id_user_left, id_user_right),
    UNIQUE(id_user_right, id_user_left)
);

-- CHANNELS

CREATE TABLE IF NOT EXISTS channels  (
    id_channel bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_owner bigint NOT NULL REFERENCES users,
    name VARCHAR,
    password VARCHAR
);

CREATE TABLE IF NOT EXISTS channel_users  (
    id_channel bigint REFERENCES channels,
    id_user bigint REFERENCES users,
    PRIMARY KEY (id_channel, id_user),
    
    is_moderator boolean DEFAULT FALSE,
    ban_time timestamptz,
    mute_time timestamptz
);
ALTER TABLE channels ADD CONSTRAINT fk_channel_owner FOREIGN KEY (id_channel, id_owner) REFERENCES channel_users;

--CONVERSATIONS

CREATE TABLE IF NOT EXISTS conversations  (
    id_conversation bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    is_channel bigint REFERENCES channels UNIQUE,
    is_discussion bigint REFERENCES discussions UNIQUE,
    CHECK ((is_channel IS NOT NULL)::integer + (is_discussion IS NOT NULL)::integer = 1)
);
ALTER TABLE discussions ADD CONSTRAINT fk_is_discussion FOREIGN KEY (id_discussion) REFERENCES conversations(is_discussion);
ALTER TABLE channels ADD CONSTRAINT fk_is_channel FOREIGN KEY (id_channel) REFERENCES conversations(is_channel);

CREATE TABLE IF NOT EXISTS conversation_messages (
    id_msg bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_conversation bigint REFERENCES conversations,
    id_sender bigint REFERENCES users,
    content varchar
);
