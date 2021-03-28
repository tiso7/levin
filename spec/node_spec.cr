require "spec"

require "../src/node"

describe Node do
    describe "init" do
        it "instance is created when new() is passed correct args" do
            node = Node.new(12)
            node.page_id.should eq 12
        end
    end

    describe "treeroot" do
        it "tree root node is correctly returned" do
            root = Node.new(0)
            second = Node.new(1, root)
            third = Node.new(2, second)

            root.root().should eq root
            second.root().should eq root
            third.root().should eq root
        end
    end
end
