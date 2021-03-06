require 'rsox'

describe 'general' do
  before :each do
    @rs = RSox.new
  end

  it 'just works' do
    i = @rs.open_read 'input.wav'
    i.class.to_s.should == 'RSoxFormat'
    i.signal.class.to_s.should == 'RSoxSignal'
  end

  it 'decode mp3 & encode pcm wav' do
    input  = @rs.open_read  'input.wav'

    sig = input.signal
    #sig.bits = 16
    #sig.bits.should == 16
    sig.channels.should == 2
    #sig.channels = 1

    newsig = RSoxSignal.new
    newsig.bits = sig.bits
    newsig.channels = sig.channels
    newsig.length = sig.length
    newsig.rate = 8000 #sig.rate

    enc = input.encoding
    #enc.bps.should == 320

    output = @rs.open_write 'output.wav', newsig #input.signal

    buf = RSoxBuffer.new 4096
    buf.length.should == 4096

    while (readed = input.read buf) > 0
      wrote = output.write buf, readed
      readed.should == wrote
    end

    #input.close.should == 0
    #output.close.should == 0
  end

  it 'checks buffer' do
    buffer = RSoxBuffer.new
    buffer.length.should == 2048
  end

end
