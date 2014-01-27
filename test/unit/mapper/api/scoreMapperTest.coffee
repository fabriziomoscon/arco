should = require 'should'
Hash  = require 'node-hash'

apiScoreMapper = require 'src/mapper/api/score'

Match = require 'src/model/Match'
Score = require 'src/model/Score'

describe 'api score mapper', ->

  describe 'marshall', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not marshall #{invalid}", ->
            (-> apiScoreMapper.marshall invalid).should.throw 'Invalid score'

    describe 'success', ->

      it 'should marshall the id', ->
        s = scoreFactory 'Indoor 18m'
        data = apiScoreMapper.marshall s
        data.id.should.equal s.id

      it 'should marshall the user id', ->
        s = scoreFactory 'Indoor 18m'
        data = apiScoreMapper.marshall s
        data.user_id.should.equal s.user_id

      it 'should marshall the type', ->
        s = scoreFactory 'Indoor 18m'
        data = apiScoreMapper.marshall s
        data.type.should.equal s.type

      it 'should marshall the total', ->
        s = scoreFactory 'Indoor 18m'
        data = apiScoreMapper.marshall s
        data.total.should.equal s.total

      it 'should marshall any set time within score times', ->
        s = scoreFactory 'Indoor 18m'
        s.times = new Hash ['created', 'half', 'empty'], Hash.comparator.Date

        s.times.created = new Date 2010, 0, 1
        s.times.half = new Date 2010, 0, 1

        data = apiScoreMapper.marshall s
        data.times.created.should.eql Math.floor s.times.created.getTime()/1000
        data.times.half.should.eql Math.floor s.times.half.getTime()/1000

        should.not.exist data.times.empty

      it 'should marshall the arrows', ->
        s = scoreFactory 'Indoor 18m'
        data = apiScoreMapper.marshall s
        should.exist data.arrows.first
        data.arrows.first.should.eql s.arrows.first
        should.exist data.arrows.second
        data.arrows.second.should.eql s.arrows.second

# ------------------------------------------------------------------------------------

  describe 'unmarshallForCreating', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not unmarshall #{invalid}", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score data'

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

      it 'should unmarshall the arrows if provided', ->
        scoreData = scoreFactory 'Indoor 18m', (v) -> v
        score = apiScoreMapper.unmarshallForCreating scoreData
        score.arrows.getData().should.eql scoreData.arrows

      it 'should unmarshall the total if arrows are not provided', ->
        scoreData = scoreFactory 'Indoor 18m', (v) -> v
        delete scoreData.arrows
        score = apiScoreMapper.unmarshallForCreating scoreData
        score.total.should.eql scoreData.total
