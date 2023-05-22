//! 347. Top K Frequent Elements
/*
    347. Top K Frequent Elements
Medium
14.1K
503
Companies
Given an integer array nums and an integer k, return the k most frequent
elements. You may return the answer in any order.

Example 1:

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
Example 2:

Input: nums = [1], k = 1
Output: [1]
 
Constraints:

1 <= nums.length <= 105
-104 <= nums[i] <= 104
k is in the range [1, the number of unique elements in the array].
It is guaranteed that the answer is unique.
 

Follow up: Your algorithm's time complexity must be better than O(n log n), 
where n is the array's size.
 */
//! best for memory wise 264 ms

//? 264 ms code

class Solution {
  List<int> topKFrequent(List<int> nums, int k) {
    if (nums.length == 1) {
      return nums;
    }
    // Bucket Sort O(n)
    Map<int, int> count = {};
    // We are making empty list of the occurrence
    // in the worst case, all element will be unique OR the same number
    // so, we make the list index represents the number of occurrence of each number
    // and then we fill its value with all the numbers that occur with that frequency
    // for instance: frequency = [[1,2,3], [4], [5], [], []].. In this case 1,2,3 occur ONE time. 4 occurs
    // TWO times. 5 occurs THREE times
    // we are creating nums.length + 1 List because the first index 0 will always be empty. Minimum occurrence is 1
    List<List<int>> frequency = List.generate(nums.length + 1, (_) => []);
    for (int i = 0; i < nums.length; i++) {
      if (count.containsKey(nums[i])) {
        count[nums[i]] = count[nums[i]]! + 1;
      } else {
        count[nums[i]] = 1; // The first occurrence
      }
    }
    count.forEach((k, v) => frequency[v].add(k));
    //print('$count');
    //print('$frequency');
    List<int> topK = [];
    for (int i = frequency.length - 1; i >= 0; i--) {
      if (frequency[i].isNotEmpty) {
        for (int num in frequency[i]) {
          topK.add(num);
          if (topK.length == k) {
            return topK;
          }
        }
      }
    }
    return topK;
  }
}

//* MY Submission Memory 148.6 MB 323 ms

class MySolution {
  List<int> topKFrequent(List<int> nums, int k) {
    Map<int, int> counter = {};
    for (int num in nums) {
      counter[num] = (counter[num] ?? 0) + 1;
    }

    List<List<int>> heap = [];
    for (MapEntry<int, int> entry in counter.entries) {
      heap.add([-entry.value, entry.key]);
    }

    heapify(heap);

    List<int> result = [];
    for (int i = 0; i < k; i++) {
      result.add(heappop(heap)[1]);
    }

    return result;
  }

  void heapify(List<List<int>> heap) {
    int length = heap.length;
    for (int i = (length ~/ 2) - 1; i >= 0; i--) {
      _sink(heap, i, length);
    }
  }

  List<int> heappop(List<List<int>> heap) {
    List<int> lastElement = heap.removeLast();
    if (heap.isNotEmpty) {
      List<int> firstElement = heap[0];
      heap[0] = lastElement;
      _sink(heap, 0, heap.length);
      return firstElement;
    }
    return lastElement;
  }

  void _sink(List<List<int>> heap, int start, int end) {
    int currentIndex = start;
    int leftChildIndex = 2 * currentIndex + 1;
    while (leftChildIndex < end) {
      int rightChildIndex = leftChildIndex + 1;
      int smallestChildIndex = (rightChildIndex < end &&
              heap[rightChildIndex][0] < heap[leftChildIndex][0])
          ? rightChildIndex
          : leftChildIndex;
      if (heap[smallestChildIndex][0] < heap[currentIndex][0]) {
        _swap(heap, smallestChildIndex, currentIndex);
        currentIndex = smallestChildIndex;
        leftChildIndex = 2 * currentIndex + 1;
      } else {
        break;
      }
    }
  }

  void _swap(List<List<int>> heap, int i, int j) {
    List<int> temp = heap[i];
    heap[i] = heap[j];
    heap[j] = temp;
  }
}
