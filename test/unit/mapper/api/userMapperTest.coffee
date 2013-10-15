should = require 'should'

apiUserMapper = require 'src/mapper/api/user'

User = require 'src/model/User'

describe 'api user mapper', ->

  describe 'marshall', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not marshall #{invalid}", ->
            (-> apiUserMapper.marshall invalid).should.throw 'Invalid user'

    describe 'succes', ->

      it 'should marshall the id', ->
        u = userFactory()
        data = apiUserMapper.marshall u
        data.id.should.equal u.id

      it 'should marshall the first_name', ->
        u = userFactory()
        data = apiUserMapper.marshall u
        data.first_name.should.equal u.first_name

      it 'should marshall the last_name', ->
        u = userFactory()
        data = apiUserMapper.marshall u
        data.last_name.should.equal u.last_name

      it 'should marshall the email', ->
        u = userFactory()
        u.setEmail 'fab@gmail.com'
        data = apiUserMapper.marshall u
        data.email.should.equal 'fab@gmail.com'

      it 'should marshall the created time', ->
        u = userFactory()
        u.setEmail 'fab@gmail.com'
        data = apiUserMapper.marshall u
        data.email.should.equal 'fab@gmail.com'

# --------------------------------------

  describe 'unmarshallForCreating', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not unmarshall #{invalid}", ->
            (-> apiUserMapper.unmarshallForCreating invalid).should.throw 'Invalid user data'

    describe 'succes', ->

      mandatoryData = 
        first_name: 'fab'
        last_name: 'mos'

      it 'should unmarshall the first_name', ->
        user = apiUserMapper.unmarshallForCreating mandatoryData
        user.should.be.instanceof User
        user.first_name.should.equal mandatoryData.first_name

      it 'should unmarshall the last_name', ->
        user = apiUserMapper.unmarshallForCreating mandatoryData
        user.should.be.instanceof User
        user.last_name.should.equal mandatoryData.last_name

      it 'should unmarshall the email', ->
        mandatoryData.email = 'fab@gmail.com'
        user = apiUserMapper.unmarshallForCreating mandatoryData
        user.should.be.instanceof User
        user.email.should.equal 'fab@gmail.com'

      it 'should unmarshall the password', ->
        mandatoryData.password = 'anypassword'
        user = apiUserMapper.unmarshallForCreating mandatoryData
        user.should.be.instanceof User
        user.password.should.equal 'anypassword'

# --------------------------------------

  describe 'unmarshallForEditing', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not marshall #{invalid}", ->
            (-> apiUserMapper.unmarshallForEditing {}, invalid).should.throw 'Invalid user'

    describe 'succes', ->

      mandatoryData = 
        first_name: 'fab'
        last_name: 'mos'      

      it 'should unmarshall the new first_name', ->
        user = new User mandatoryData
        editedUser = apiUserMapper.unmarshallForEditing {first_name: 'xxx'}, user
        editedUser.should.be.instanceof User
        editedUser.first_name.should.equal 'xxx'

      it 'should unmarshall the new last_name', ->
        user = new User mandatoryData
        editedUser = apiUserMapper.unmarshallForEditing {last_name: 'xxx'}, user
        editedUser.should.be.instanceof User
        editedUser.last_name.should.equal 'xxx'

      it 'should unmarshall the new email', ->
        user = new User mandatoryData
        user.setEmail 'fab@gmail.com'
        editedUser = apiUserMapper.unmarshallForEditing {email: 'xxx@gmail.com'}, user
        editedUser.should.be.instanceof User
        editedUser.email.should.equal 'xxx@gmail.com'

      it 'should unmarshall the new password', ->
        user = new User mandatoryData
        user.setPassword 'initialPassword'
        editedUser = apiUserMapper.unmarshallForEditing {password: 'aNewPassword'}, user
        editedUser.should.be.instanceof User
        editedUser.password.should.equal 'aNewPassword'
