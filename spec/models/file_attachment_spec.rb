require 'rails_helper'

describe "FileAttachment" do

  describe ".from_uploadable_file" do
    it "should extract content type from uploaded_file" do
      uploaded_file = uploadable_audio
      uploaded_file.should_receive(:content_type)
      FileAttachment.from_uploadable_file(uploaded_file);

    end

    it "should call .from_file with all parameters and content_type extracted from uploaded_file" do
      uploaded_audio = uploadable_audio
      FileAttachment.should_receive(:from_file).with(uploaded_audio, uploaded_audio.content_type, "prefix", "postfix", nil)
      FileAttachment.from_uploadable_file(uploaded_audio, "prefix", "postfix")
    end

  end

  describe ".from_file" do
    before(:each) do
      @file = stub("File")
      @file.stub(:original_filename).and_return("i_am_a_file")
      File.stub(:binread).with(@file).and_return("Data")
    end

    it "should create an instance with content type from given file" do
      attachment = FileAttachment.from_file(@file, 'image/jpg')
      attachment.content_type.should == 'image/jpg'
    end

    it "should create an instance with data from given file" do
      File.stub(:binread).with(@file).and_return("file_contents")
      attachment = FileAttachment.from_file(@file, '')
      attachment.data.read.should == 'file_contents'
    end
  end

  describe '#resize' do
    before :each do
      @child = stub_model Child
      @data = double()
      @attachment = FileAttachment.new "test", "image/jpg", @data, @child
    end

    it 'should create and save new thumbnail' do
      new_data = double()
      StringIO.stub :new => new_data

      @child.should_receive(:has_attachment?).with('test_160').and_return(false)
      @child.should_receive(:attach).and_return(false)
      @child.should_receive(:save).and_return(false)
      @attachment.should_receive(:resized_blob).and_return(new_data)

      actual = @attachment.resize("160")
      actual.data.should == new_data
      actual.name.should == 'test_160'
      actual.content_type.should == 'image/jpg'
      actual.child.should == @child
    end

    it 'should return existing thumbnail' do
      media = double()
      @child.should_receive(:has_attachment?).with('test_160').and_return(true)
      @child.should_receive(:media_for_key).with('test_160').and_return(media)
      @attachment.should_not_receive(:resized_blob)

      @attachment.resize("160").should == media
    end
  end

end
