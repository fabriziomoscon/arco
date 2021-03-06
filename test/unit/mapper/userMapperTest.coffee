should   = require 'should'
ObjectID = require('mongodb').ObjectID
Hash     = require 'node-hash'

userMapper = require 'src/mapper/user'

mockUsers = require('test/data/db/user').getData()


describe 'user mapper', ->

  describe 'marshall', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not marshall #{invalid}", ->
            (-> userMapper.marshall invalid).should.throw 'Invalid user'

    describe 'success', ->

      it 'should marshall the _id', ->
        data = userMapper.marshall userFactory 'validUser1'
        should.exist data._id
        data._id.should.be.instanceof ObjectID

      it 'should marshall the first name', ->
        user1 = userFactory 'validUser1'
        data = userMapper.marshall user1
        data.first_name.should.equal user1.first_name

      it 'should marshall the last name', ->
        user1 = userFactory 'validUser1'
        data = userMapper.marshall user1
        data.last_name.should.equal user1.last_name

      it 'should marshall the email', ->
        u = userFactory 'validUser1'
        u.email = 'fabmos@gmail.com'
        data = userMapper.marshall u
        data.email.should.equal 'fabmos@gmail.com'

      it 'should marshall the password', ->
        u = userFactory 'validUser1'
        u.password = 'mysupersecurepassword'
        data = userMapper.marshall u
        data.password.should.equal 'mysupersecurepassword'

      it 'should marshall the gender', ->
        u = userFactory 'validUser1'
        u.gender = 'F'
        data = userMapper.marshall u
        data.gender.should.equal 'F'

      it 'should marshall the birthdate', ->
        u = userFactory 'validUser1'
        u.birthdate = new Date 1960, 0, 1
        data = userMapper.marshall u
        data.birthdate.should.eql new Date 1960, 0, 1

      it 'should marshall the times', ->
        u = userFactory 'validUser1'
        u.times.created = new Date 2013, 0, 1
        data = userMapper.marshall u
        data.times.created.should.eql new Date 2013, 0, 1

  describe 'unmarshall', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not unmarshall #{invalid}", ->
            (-> userMapper.unmarshall invalid).should.throw 'Invalid data'

    describe 'success', ->

      it 'should unmarshall the _id', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'id'
        user.id.should.equal mockUsers.validUser1._id.toHexString()

      it 'should unmarshall the first_name', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'first_name'
        user.first_name.should.equal mockUsers.validUser1.first_name

      it 'should unmarshall the last_name', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'last_name'
        user.last_name.should.equal mockUsers.validUser1.last_name

      it 'should unmarshall the email', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'email'
        user.email.should.equal mockUsers.validUser1.email

      it 'should unmarshall the password', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'password'
        user.password.should.equal mockUsers.validUser1.password

      it 'should unmarshall the birthdate', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'birthdate'
        user.birthdate.should.be.instanceof Date
        user.birthdate.should.equal mockUsers.validUser1.birthdate

      it 'should unmarshall the gender', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'gender'
        user.gender.should.equal mockUsers.validUser1.gender

      it 'should unmarshall the times', ->
        user = userMapper.unmarshall mockUsers.validUser1
        user.should.have.property 'times'
        user.times.should.be.instanceof Hash
        user.times.getData().should.have.property 'created'
        user.times.created.should.be.instanceof Date
