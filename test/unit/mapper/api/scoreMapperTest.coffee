should = require 'should'

apiScoreMapper = require 'src/mapper/api/score'

Match = require 'src/model/Match'
Score = require 'src/model/Score'


describe 'api score mapper', ->

  describe 'unmarshallForCreating', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not unmarshall #{invalid}", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score data'

      call() for call in [{}, {x:1}].map (invalid) ->
        () ->
          it "should not unmarshall #{invalid} as user_id", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score user_id'

      call() for call in [{user_id:10}].map (invalid) ->
        () ->
          it "should not unmarshall #{invalid} as type", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score type'

    describe 'success', ->

      mandatoryData =
        user_id:'5aa896ddc814556766002001'
        type: Object.keys(Match.TYPES)[0]

      it 'should unmarshall the user_id', ->
        score = apiScoreMapper.unmarshallForCreating mandatoryData
        score.should.be.instanceof Score
        score.user_id.should.equal mandatoryData.user_id

      it 'should unmarshall the type', ->
        score = apiScoreMapper.unmarshallForCreating mandatoryData
        score.should.be.instanceof Score
        score.type.should.equal mandatoryData.type
