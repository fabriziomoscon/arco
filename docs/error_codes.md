User
====

- 1001 GET     user:  400 'invalid user id'
- 1002 GET     user:  404 'user not found'
- 1003 GET     user:  500 'impossible finding a user'

- 1010 POST    user: 400 'invalid user data'
- 1011 POST    user: 400 'invalid user data validation'
- 1012 POST    user: 500 'invalid user data during API mapping'
- 1013 POST    user: 500 'impossible creating a user'

- 1020 PUT     user: 400 'invalid user id'
- 1021 PUT     user: 400 'invalid body'
- 1023 PUT     user: 400 'invalid user data validation'
- 1024 PUT     user: 500 'invalid user data during API mapping'
- 1025 PUT     user: 500 'impossible editing a user'

- 1030 DELETE  user: 400 'invalid user id'
- 1031 DELETE  user: 404 'user not found'
- 1032 DELETE  user: 500 'impossible removing the user'

- 1041 GET     users: 500 'impossible finding all users' 

Auth
====

- 2001 POST    login: 400 'impossible to login'
- 2002 POST    login: 401 'wrong email or password'
- 2002 POST    login: 500 'impossible to login'
