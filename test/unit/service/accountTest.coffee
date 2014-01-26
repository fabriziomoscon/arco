should = require 'should'

AccountService = require 'src/service/Account'

UserRepository = require 'src/repository/User'

User = require 'src/model/User'


describe 'Account service', ->

  describe 'constructor', ->

    describe 'defaults', ->

      call() for call in [null, undefined].map (def) ->
        () ->
          it "should accept #{def} as default repository", ->
            (-> new AccountService def).should.not.throw()
            as = new AccountService def
            should.exist as.userRepository

    describe 'success', ->

      it 'should set a passed repository', ->
        mockRepository = {source: ()->}
        as = new AccountService mockRepository
        as.userRepository.should.eql mockRepository

# ---------------------------------------------------------------

  describe 'findUserByEmail', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.findUserByEmail 'fab@gmail.com', invalid).should.throw 'Invalid callback'
      
      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as email", (done) ->
            as = new AccountService
            as.findUserByEmail invalid, (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid email'
              should.not.exist user
              done()

    describe 'success', ->

      it 'should return a user', (done) ->
        mockSource = {
          findOneByEmail: (email, callback) -> callback null, {first_name: 'fab', last_name: 'mos', email: 'fab@gmail.com'}
        }
        as = new AccountService new UserRepository mockSource
        as.findUserByEmail 'fab@gmail.com', (err, user) ->
          should.not.exist err
          should.exist user
          user.should.be.instanceof User
          done()

# ---------------------------------------------------------------

  describe 'findUserById', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.findUserById '50b896ddc814556766000001', invalid).should.throw 'Invalid callback'
      
      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", (done) ->
            as = new AccountService
            as.findUserById invalid, (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid userId'
              should.not.exist user
              done()

    describe 'success', ->

      it 'should return a user', (done) ->
        mockSource = {
          findOneById: (userId, callback) -> callback null, {first_name: 'fab', last_name: 'mos'}
        }
        as = new AccountService new UserRepository mockSource
        as.findUserById '50b896ddc814556766000001', (err, user) ->
          should.not.exist err
          should.exist user
          user.should.be.instanceof User
          done()

# ---------------------------------------------------------------

  describe 'findAllUsers', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.findAllUsers null, null, invalid).should.throw 'Invalid callback'

    describe 'success', ->

      it 'should return all users', (done) ->
        mockSource = {
          findAll: (offset, limit, callback) -> callback null, [
            {first_name: 'fab', last_name: 'mos'}
            {first_name: 'john', last_name: 'lewis'}
            {first_name: 'darren', last_name: 'reuter'}
          ]
        }
        as = new AccountService new UserRepository mockSource
        as.findAllUsers null, null, (err, users) ->
          should.not.exist err
          should.exist users
          users.should.be.instanceof Array
          users[0].should.be.instanceof User
          users[1].should.be.instanceof User
          users[2].should.be.instanceof User
          done()

# ------------------------------------------------------------------

  describe 'removeUserById', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.removeUserById '50b896ddc814556766000001', invalid).should.throw 'Invalid callback'

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", (done) ->
            as = new AccountService
            as.removeUserById invalid, (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid userId'
              should.not.exist user
              done()

    describe 'success', ->

      it 'should remove a user', (done) ->
        mockSource = {
          remove: (userId, callback) -> callback null, 1
        }
        as = new AccountService new UserRepository mockSource
        as.removeUserById '50b896ddc814556766000001', (err, status) ->
          should.not.exist err
          status.should.equal 1
          done()

# ------------------------------------------------------------------

  describe 'createUser', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.createUser userFactory(), invalid).should.throw 'Invalid callback'

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as user", (done) ->
            as = new AccountService
            as.createUser invalid, (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid user'
              should.not.exist user
              done()

      it 'should return an error from the source', (done) ->
        mockSource = {
          findOneByEmail: (email, callback) -> callback null, null
          insert: (users, callback) -> callback new Error 'The DB exploded', null
        }
        as = new AccountService new UserRepository mockSource
        as.createUser userFactory(), (err, user) ->
          should.not.exist user
          should.exist err
          err.message.should.equal 'The DB exploded'
          done()

      it 'should return an error if there are no users returned from the insertion', (done) ->
        mockSource = {
          findOneByEmail: (email, callback) -> callback null, null
          insert: (users, callback) -> callback null, null
        }
        as = new AccountService new UserRepository mockSource
        as.createUser userFactory(), (err, user) ->
          should.not.exist user
          should.exist err
          err.message.should.equal 'No user created'
          done()

    describe 'forbids', ->

      it 'should not allow to use an email already used', (done) ->
        mockSource = {
          findOneByEmail: (email, callback) -> callback null, {first_name: 'fab', last_name: 'mos', email: 'fab@gmail.com'}
          insert: (users, callback) -> callback null, users
        }
        as = new AccountService new UserRepository mockSource
        as.createUser userFactory(), (err, user) ->
          should.not.exist user
          should.exist err
          err.message.should.equal 'email already used'
          done()

    describe 'success', ->

      it 'should return the user created', (done) ->
        mockSource = {
          findOneByEmail: (email, callback) -> callback null, null
          insert: (users, callback) -> callback null, users
        }
        as = new AccountService new UserRepository mockSource
        as.createUser userFactory('f', 'm'), (err, user) ->
          should.not.exist err
          user.should.be.instanceof User
          user.first_name.should.equal 'f'
          user.last_name.should.equal 'm'
          done()

# ------------------------------------------------------------------

  describe 'updateUserById', ->

    describe 'failures', ->

      call() for call in allNotFunctionTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as callback", ->
            as = new AccountService
            (-> as.updateUserById '50b896ddc814556766000001', userFactory(), invalid).should.throw 'Invalid callback'

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as user id", (done) ->
            as = new AccountService
            as.updateUserById invalid, userFactory(), (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid userId'
              should.not.exist user
              done()

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as user", (done) ->
            as = new AccountService
            as.updateUserById '50b896ddc814556766000001', invalid, (err, user) ->
              should.exist err
              err.message.should.equal 'Invalid user'
              should.not.exist user
              done()
