data class Region(
    val north: Double,
    val east: Double,
    val south: Double,
    val west: Double,
) {
    fun encode(): List<Any?> {
        return listOf(north, east, south, west)
    }
} 