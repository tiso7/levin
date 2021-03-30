# The map size and array pointer size should vary depending on the
# CPU architecture.

# Listing supported CPU types

# 64 bit platforms
# - AMD64 (x86_64)
# - ARM

# In theory these should also work but we haven't tested them
# - riscv64
# - ppc64
# - ppc64le
# - riscv64
# - s390x

# We can use these constants to specify module level globals later
# XXX: Maybe there's a better design for this

# MAX_MAP_SIZE represents the largest mmap size supported by Levin.
# MAX_ALLOC_SIZE is the size used when creating array pointers.

# Generic 64 bits
lib CPU_SETTINGS_64
    MAX_MAP_SIZE = 0x7FFFFFFF # 2GB
    MAX_ALLOC_SIZE = 0xFFFFFFF
end
