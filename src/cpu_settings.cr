# The map size and array pointer size should vary depending on the
# CPU architecture.

# Listing supported CPU types

# 32 bit platforms
# - 386
# - ARM
# - mipsx
# - ppc

# 64 bit platforms
# - AMD64 (x86_64)
# - ARM
# - mips64x
# - riscv64
# - ppc64
# - ppc64le
# - riscv64
# - s390x

# We can use these constants to specify module level globals later
# XXX: Maybe there's a better design for this

# MAX_MAP_SIZE represents the largest mmap size supported by Levin.
# MAX_ALLOC_SIZE is the size used when creating array pointers.

# Generic 32 bits
lib CPU_SETTINGS_32
    MAX_MAP_SIZE = 0xFFFFFFFFFFFF # 256TB
    MAX_ALLOC_SIZE = 0x7FFFFFFF
end

# Generic 64 bits
lib CPU_SETTINGS_64
    MAX_MAP_SIZE = 0x7FFFFFFF # 2GB
    MAX_ALLOC_SIZE = 0xFFFFFFF
end

# special settings for less generic CPUs
# mips
lib CPU_SETTINGS_MIPS_32
    MAX_MAP_SIZE = 0x40000000 # 1GB
    MAX_ALLOC_SIZE = 0xFFFFFFF
end

lib CPU_SETTINGS_MIPS_64
    MAX_MAP_SIZE = 0x8000000000 # 512GB
    MAX_ALLOC_SIZE = 0x7FFFFFFF
end
