require "./page"

# Equivalent to the bbolt "bucket" struct
# This is stored as the "value" of a bucket key. If the bucket is small enough,
# then its root page can be stored inline in the "value", after the bucket
# header. In the case of inline buckets, the "root" will be 0.
class BaseBucket
    property page_id : PageId
    property sequence : UInt64

    def initialize(page_id : PageId, sequence : UInt64)
        @page_id = page_id
        @sequence = sequence
    end
end

# Bucket represents a collection of key/value pairs inside the database.
class Bucket < BaseBucket

    # Sets the threshold for filling nodes when they split. By default,
	# the bucket will fill to 50% but it can be useful to increase this
	# amount if you know that your write workloads are mostly append-only.
	#
	# This is non-persisted across transactions so it must be set in every Tx.
    property fill_percent : Float64

    def initialize(page_id : PageId, sequence : UInt64, fill_percent : Float64 = 0.5)
        super(page_id, sequence)
        @fill_percent = fill_percent
    end
end