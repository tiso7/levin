require "./page"

class Node
    property page_id : PageId
    property parent : Node?

    def initialize(page_id : PageId, parent : Node? = nil)
        @page_id = page_id
        @parent = parent
    end

    def root()
        # NB: We have to do this weird assignment because crystal lets other fibers
        # mess with class variables so we have to assign it locally or the compiler
        # will not recognize "parent" as valid inside the condition
        if parent = @parent
            return parent.root()
        end
        return self
    end
end
