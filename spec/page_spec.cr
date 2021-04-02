require "./spec_helper"

describe Page do
  describe "#typ" do
    it "correctly returns the branch page type" do
      Page.new(PageId.new(1), BRANCH_PAGE_FLAG, UInt16.new(0), UInt32.new(0)).typ.should eq "branch"
    end

    it "correctly returns the leaf page type" do
      Page.new(PageId.new(1), LEAF_PAGE_FLAG, UInt16.new(0), UInt32.new(0)).typ.should eq "leaf"
    end

    it "correctly returns the meta page type" do
      Page.new(PageId.new(1), META_PAGE_FLAG, UInt16.new(0), UInt32.new(0)).typ.should eq "meta"
    end

    it "correctly returns the freelist page type" do
      Page.new(PageId.new(1), FREELIST_PAGE_FLAG, UInt16.new(0), UInt32.new(0)).typ.should eq "freelist"
    end

    it "correctly returns the unkown page type" do
      Page.new(PageId.new(1), 20000, 0, 0).typ.should eq "unknown<4e20>"
    end
  end

  # Ensure that the hexdump debugging function doesn't blow up.
  describe "#dump" do
    it "does not blow up" do
      Stdio.capture do |io|
        Page.new(PageId.new(256), 0, 0, 0).hexdump(16)
        io.err.gets.should eq "00010000000000000000000000000000"
      end
    end
  end
end

describe PageIds do
  describe "#merge" do
    it "correctly merge and sort the 2 lists of page ids" do
      a = PageIds{4, 5, 6, 10, 11, 12, 13, 27}
      b = PageIds{1, 3, 8, 9, 25, 30}
      c = a.merge(b)
      c.should eq PageIds{1, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 25, 27, 30}

      a = PageIds{4, 5, 6, 10, 11, 12, 13, 27, 35, 36}
      b = PageIds{8, 9, 25, 30}
      c = a.merge(b)
      c.should eq PageIds{4, 5, 6, 8, 9, 10, 11, 12, 13, 25, 27, 30, 35, 36}
    end
  end
end

# TODO: We should add a black box test similar to how they use quick library in bbolt
