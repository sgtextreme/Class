DROP TABLE users;
DROP TABLE questions; 
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE questions_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL 
);


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255),
  parent_reply_id INTEGER, 
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id), 
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE questions_likes (
  id INTEGER PRIMARY KEY, 
  liked_q_id INTEGER NOT NULL,
  user_that_liked_id INTEGER NOT NULL,
  FOREIGN KEY (liked_q_id) REFERENCES questions(id),
  FOREIGN KEY (user_that_liked_id) REFERENCES users(id) 
);

INSERT INTO users (id, fname, lname)
VALUES (1, 'Alice', 'Kong');

INSERT INTO question_follows (id, question_id, follower_id)
VALUES (1, 1, 1);

