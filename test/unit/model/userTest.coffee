should = require 'should'

User =  require 'src/model/User'


describe 'user model', ->

  describe 'contructor', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as properties", ->
            (-> new User invalid).should.throw 'Invalid properties'

    describe 'success', ->

      it 'should accept first name and last name', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        u.first_name.should.equal 'fabrizio'
        u.last_name.should.equal 'moscon'

      it 'should have times', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.times

      it 'should have places', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.places

      it 'should have records', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.records

# --------------------------------------------------

  describe 'id setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", ->
            u = userFactory()
            (-> u.id = invalid).should.throw 'Invalid id'

    describe 'success', ->

      it 'should accept a valid id', ->
        u = userFactory()
        u.id = '50b896ddc814556766000999'
        u.id.should.equal '50b896ddc814556766000999'

# --------------------------------------------------

  describe 'email setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as email", ->
            u = userFactory()
            (-> u.email = invalid).should.throw 'Invalid email'

    describe 'success', ->

      it 'should accept a valid email', ->
        u = userFactory()
        u.email = 'fabrizio@arco.com'
        u.email.should.equal 'fabrizio@arco.com'

# --------------------------------------------------

  describe 'first name setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as first name", ->
            u = userFactory()
            (-> u.first_name = invalid).should.throw 'Invalid first name'

    describe 'success', ->

      it 'should accept a valid first name', ->
        u = userFactory()
        u.first_name = 'fabrizio'
        u.first_name.should.equal 'fabrizio'

# --------------------------------------------------

  describe 'last name setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as last name", ->
            u = userFactory()
            (-> u.last_name = invalid).should.throw 'Invalid last name'

    describe 'success', ->

      it 'should accept a valid last name', ->
        u = userFactory()
        u.last_name = 'moscon'
        u.last_name.should.equal 'moscon'

# --------------------------------------------------

  describe 'passwrod setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as passwrod", ->
            u = userFactory()
            (-> u.password = invalid).should.throw 'Invalid password'

    describe 'success', ->

      it 'should accept a valid password', ->
        u = userFactory()
        u.password = '$2a$08$e7Stv.uikafq58WDe1J1YOenKgMdCWgEo/6EVCTxOJ8p9Sdyl5kzq'
        u.password.should.equal '$2a$08$e7Stv.uikafq58WDe1J1YOenKgMdCWgEo/6EVCTxOJ8p9Sdyl5kzq'

# --------------------------------------------------

  describe 'birthdate setter/getter', ->

    describe 'failures', ->

      call() for call in allNotDatesTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as birthdate", ->
            u = userFactory()
            (-> u.birthdate = invalid).should.throw 'Invalid birthdate'

    describe 'success', ->

      it 'should accept a valid birthdate', ->
        u = userFactory()
        u.birthdate = new Date 1983, 5, 6
        u.birthdate.should.eql new Date 1983, 5, 6

# --------------------------------------------------

  describe 'gender setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as gender", ->
            u = userFactory()
            (-> u.gender = invalid).should.throw 'Invalid gender'

    describe 'success', ->

      it 'should accept M as gender', ->
        u = userFactory()
        u.gender = 'M'
        u.gender.should.equal 'M'

      it 'should accept F as gender', ->
        u = userFactory()
        u.gender = 'F'
        u.gender.should.equal 'F'
