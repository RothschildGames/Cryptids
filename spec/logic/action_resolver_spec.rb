require './logic/action_resolver'

describe ActionResolver do

  let(:player) { mock(:player) }
  subject { ActionResolver.new(player) }

  describe :defense do
    it 'should always return 0,0' do
      subject

    end
  end
end