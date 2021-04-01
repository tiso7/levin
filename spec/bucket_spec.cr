require "spec"

require "../src/bucket"

describe BaseBucket do
    describe "init" do
        it "works properly with the correct args" do
            bb = BaseBucket.new(22, 400)
            bb.page_id.should eq 22
            bb.sequence.should eq 400
        end
    end
end

describe Bucket do
    describe "init" do
        it "works properly with the correct args" do
            bb = Bucket.new(22, 400, 0.25)
            bb.page_id.should eq 22
            bb.sequence.should eq 400
            bb.fill_percent.should eq 0.25
        end
        it "correctly defaults the fill percentage" do
            bb = Bucket.new(22, 400)
            bb.fill_percent.should eq 0.5
        end
    end
end