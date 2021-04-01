def unsafe_add(base : Pointer, offset : Int64) : Pointer
    base + offset
end
     
def unsafe_byte_slice(base : Object, offset : Int64, i : Int64, j : Int64)
    s = Slice.new(unsafe_add(base, offset), j - i, read_only: true)
    Bytes.new(s.to_unsafe.as(Pointer(UInt8)), j - i)
end
