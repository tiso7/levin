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

# func TestPgids_merge(t *testing.T) {
# 	a := pgids{4, 5, 6, 10, 11, 12, 13, 27}
# 	b := pgids{1, 3, 8, 9, 25, 30}
# 	c := a.merge(b)
# 	if !reflect.DeepEqual(c, pgids{1, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 25, 27, 30}) {
# 		t.Errorf("mismatch: %v", c)
# 	}

# 	a = pgids{4, 5, 6, 10, 11, 12, 13, 27, 35, 36}
# 	b = pgids{8, 9, 25, 30}
# 	c = a.merge(b)
# 	if !reflect.DeepEqual(c, pgids{4, 5, 6, 8, 9, 10, 11, 12, 13, 25, 27, 30, 35, 36}) {
# 		t.Errorf("mismatch: %v", c)
# 	}
# }

# func TestPgids_merge_quick(t *testing.T) {
# 	if err := quick.Check(func(a, b pgids) bool {
# 		# Sort incoming lists.
# 		sort.Sort(a)
# 		sort.Sort(b)

# 		# Merge the two lists together.
# 		got := a.merge(b)

# 		# The expected value should be the two lists combined and sorted.
# 		exp := append(a, b...)
# 		sort.Sort(exp)

# 		if !reflect.DeepEqual(exp, got) {
# 			t.Errorf("\nexp=%+v\ngot=%+v\n", exp, got)
# 			return false
# 		}

# 		return true
# 	}, nil); err != nil {
# 		t.Fatal(err)
# 	}
# }