require "./unsafe.cr"

PAGE_HEADER_SIZE = instance_sizeof(Page)

MIN_KEYS_PER_PAGE = 2

BRANCH_PAGE_ELEMENT_SIZE = instance_sizeof(BranchPageElement)
LEAF_PAGE_ELEMENT_SIZE = instance_sizeof(LeafPageElement)

BRANCH_PAGE_FLAG = UInt16.new(0x01)
LEAF_PAGE_FLAG = UInt16.new(0x02)
META_PAGE_FLAG = UInt16.new(0x04)
FREELIST_PAGE_FLAG = UInt16.new(0x10)

BUCKET_LEAF_FLAG = 0x01

alias PageId = UInt64

struct Page
  def initialize(id : PageId, flags : UInt16, count : UInt16, overflow : UInt32)
    @id = id
    @flags = flags
    @count = count
    @overflow = overflow
  end

  # typ returns a human readable page type string used for debugging.
  def typ() : String
    if (@flags & BRANCH_PAGE_FLAG) != 0
      "branch"
    elsif (@flags & LEAF_PAGE_FLAG) != 0
      "leaf"
    elsif (@flags & META_PAGE_FLAG) != 0
      "meta"
    elsif (@flags & FREELIST_PAGE_FLAG) != 0
      "freelist"
    else
      "unknown<#{@flags.to_s(16)}>"
    end
  end

  # TODO: Finishing methods
  # # meta returns a pointer to the metadata section of the page.
  # func (p *page) meta() *meta {
  #     return (*meta)(unsafeAdd(unsafe.Pointer(p), unsafe.Sizeof(*p)))
  # }

  # # leafPageElement retrieves the leaf node by index
  # func (p *page) leafPageElement(index uint16) *leafPageElement {
  #     return (*leafPageElement)(unsafeIndex(unsafe.Pointer(p), unsafe.Sizeof(*p),
  #         leafPageElementSize, int(index)))
  # }

  # # leafPageElements retrieves a list of leaf nodes.
  # func (p *page) leafPageElements() []leafPageElement {
  #     if p.count == 0 {
  #         return nil
  #     }
  #     var elems []leafPageElement
  #     data := unsafeAdd(unsafe.Pointer(p), unsafe.Sizeof(*p))
  #     unsafeSlice(unsafe.Pointer(&elems), data, int(p.count))
  #     return elems
  # }

  # # branchPageElement retrieves the branch node by index
  # func (p *page) branchPageElement(index uint16) *branchPageElement {
  #     return (*branchPageElement)(unsafeIndex(unsafe.Pointer(p), unsafe.Sizeof(*p),
  #         unsafe.Sizeof(branchPageElement{}), int(index)))
  # }

  # # branchPageElements retrieves a list of branch nodes.
  # func (p *page) branchPageElements() []branchPageElement {
  #     if p.count == 0 {
  #         return nil
  #     }
  #     var elems []branchPageElement
  #     data := unsafeAdd(unsafe.Pointer(p), unsafe.Sizeof(*p))
  #     unsafeSlice(unsafe.Pointer(&elems), data, int(p.count))
  #     return elems
  # }

  # dump writes n bytes of the page to STDERR as hex output.
  def hexdump(n : Int64)
    buf = unsafe_byte_slice(pointerof(@id), 0, 0, n)
    STDERR.puts buf.hexstring
  end
end

# TODO: This may need to be rewritten depending on needs
class Pages
  def initialize(p : Array(Page))
    @p = p
  end

  def len : Int
    @p.size
  end

  def swap(i, j : Int)
    t = @p[i]
    @p[i] = @p[j]
    @p[j] = t
  end

  def less(i, j : Int) : Bool
    @p[i].id < @p[j].id
  end
end

# branchPageElement represents a node on a branch page.
class BranchPageElement
  def initialize(pos : UInt32, ksize : UInt32, pgid : Pgid)
    @pos = pos
    @ksize = ksize
    @pgid = pgid
  end

  # TODO: Finish key method
  # # key returns a byte slice of the node key.
  # def key : Bytes
  # end
  # func (n *branchPageElement) key() []byte {
  #   return unsafeByteSlice(unsafe.Pointer(n), 0, int(n.pos), int(n.pos)+int(n.ksize))
  # }
end

# leafPageElement represents a node on a leaf page.
class LeafPageElement
  def initialize(flags : UInt32, pos : UInt32, ksize : UInt32, vsize : UInt32)
    @flags = flags
    @pos = pos
    @ksize = ksize
    @vsize = vsize
  end

  # TODO: Finish methods
  # # key returns a byte slice of the node key.
  # def key : Bytes
  # end
  # func (n *leafPageElement) key() []byte {
  #   i := int(n.pos)
  #   j := i + int(n.ksize)
  #   return unsafeByteSlice(unsafe.Pointer(n), 0, i, j)
  # }

  # # value returns a byte slice of the node value.
  # def value : Bytes
  # end
  # func (n *leafPageElement) value() []byte {
  #   i := int(n.pos) + int(n.ksize)
  #   j := i + int(n.vsize)
  #   return unsafeByteSlice(unsafe.Pointer(n), 0, i, j)
  # }
end


# TODO: Finish this struct
# # PageInfo represents human readable information about a page.
# type PageInfo struct {
# 	ID            int
# 	Type          string
# 	Count         int
# 	OverflowCount int
# }

class PageIds < Array(PageId)
  # merge returns the sorted union of self and b
  def merge(b : PageIds) : PageIds
    (self + b).sort.unsafe_as(PageIds)
  end
end
