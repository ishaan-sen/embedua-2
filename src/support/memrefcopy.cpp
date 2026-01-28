#include <stdint.h>
#include <string.h>

// MLIR unranked memref ABI:
// UnrankedMemRefType<T> { int64_t rank; void* descriptor; }  :contentReference[oaicite:2]{index=2}
typedef struct {
  int64_t rank;
  void *descriptor;
} UnrankedMemRefType_char;

// The descriptor layout is the "strided memref" form:
// { T* basePtr; T* data; int64_t offset; int64_t sizes[rank]; int64_t strides[rank]; }
// (C++ side is StridedMemRefType<T, N> with sizes/strides arrays). :contentReference[oaicite:3]{index=3}
typedef struct {
  char *basePtr;
  char *data;
  int64_t offset;
  // followed by: int64_t sizes[rank]; then int64_t strides[rank];
} StridedMemRefDescriptorPrefix;

static inline int64_t *get_sizes(const StridedMemRefDescriptorPrefix *d) {
  return (int64_t *)((char *)d + sizeof(StridedMemRefDescriptorPrefix));
}
static inline int64_t *get_strides(const StridedMemRefDescriptorPrefix *d, int64_t rank) {
  return get_sizes(d) + rank;
}

static int is_contiguous_row_major(const int64_t *sizes, const int64_t *strides, int64_t rank) {
  if (rank == 0) return 1;
  if (strides[rank - 1] != 1) return 0;
  for (int64_t i = rank - 2; i >= 0; --i) {
    if (strides[i] != strides[i + 1] * sizes[i + 1]) return 0;
  }
  return 1;
}

static int64_t num_elems(const int64_t *sizes, int64_t rank) {
  int64_t n = 1;
  for (int64_t i = 0; i < rank; ++i) n *= sizes[i];
  return n;
}

// Provide the exact symbol name MLIR expects.
// (This is what mlir_c_runner_utils exports). :contentReference[oaicite:4]{index=4}
#ifdef __cplusplus
extern "C" {
#endif

void memrefCopy(int64_t elemSize, UnrankedMemRefType_char *srcArg, UnrankedMemRefType_char *dstArg) {
  const int64_t rank = srcArg->rank;
  if (rank != dstArg->rank) return; // or handle error

  const StridedMemRefDescriptorPrefix *srcD =
      (const StridedMemRefDescriptorPrefix *)srcArg->descriptor;
  const StridedMemRefDescriptorPrefix *dstD =
      (const StridedMemRefDescriptorPrefix *)dstArg->descriptor;

  const int64_t *srcSizes = get_sizes(srcD);
  const int64_t *srcStrides = get_strides(srcD, rank);
  const int64_t *dstSizes = get_sizes(dstD);
  const int64_t *dstStrides = get_strides(dstD, rank);

  // Assume shapes match; you can add checks if you want.
  // Fast path: both contiguous row-major.
  if (is_contiguous_row_major(srcSizes, srcStrides, rank) &&
      is_contiguous_row_major(dstSizes, dstStrides, rank)) {
    int64_t n = num_elems(srcSizes, rank);
    const char *srcPtr = srcD->data + (srcD->offset * elemSize);
    char *dstPtr = dstD->data + (dstD->offset * elemSize);
    memcpy(dstPtr, srcPtr, (size_t)(n * elemSize));
    return;
  }

  // Generic path: iterate over all indices with an odometer.
  int64_t idx[8]; // bump this if you might have rank > 8 on embedded
  if (rank > (int64_t)(sizeof(idx) / sizeof(idx[0]))) return;

  for (int64_t i = 0; i < rank; ++i) idx[i] = 0;

  while (1) {
    int64_t srcLin = srcD->offset;
    int64_t dstLin = dstD->offset;
    for (int64_t d = 0; d < rank; ++d) {
      srcLin += idx[d] * srcStrides[d];
      dstLin += idx[d] * dstStrides[d];
    }

    memcpy(dstD->data + dstLin * elemSize, srcD->data + srcLin * elemSize, (size_t)elemSize);

    // increment odometer
    int64_t carryDim = rank - 1;
    while (carryDim >= 0) {
      idx[carryDim]++;
      if (idx[carryDim] < srcSizes[carryDim]) break;
      idx[carryDim] = 0;
      carryDim--;
    }
    if (carryDim < 0) break;
  }
}

#ifdef __cplusplus
} // extern "C"
#endif
