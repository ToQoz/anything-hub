require 'spec_helper'

describe AnythingHub do
  describe 'test loading rc files' do
    before do
      AnythingHub::HOME_RC_FILE.replace('spec/fixtures/testrc')
    end
    after do
      AnythingHub::HOME_RC_FILE.replace('~/.anything-hubrc')
    end

    context 'when AnythingHub init' do
      before do
        AnythingHub.init
      end

      it 'should set login' do
        AnythingHub.config.login.should eq('ToQoz')
      end
    end
  end
end
