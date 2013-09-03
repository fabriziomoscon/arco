should = require 'should'

UserMapper = require 'src/mapper/User'


describe 'marshall', ->

  describe 'failures', ->

    call() for call in [undefined, null, false, 1, NaN, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should not marshall #{invalid}", ->
          (-> UserMapper.marshall invalid).should.throw 'Invalid user'

    it 'should marshall the first name', ->
      u = userFactory()
      u.first_name.should.equal 'Fab'


  describe 'success', ->
