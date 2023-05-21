//! TWO SUM
/** //? Question 1
Given an array of integers nums and an integer target, return indices of the
 two numbers such that they add up to target.

You may assume that each input would have exactly one solution,
 and you may not use the same element twice.You can return the answer in any order.
 Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]
Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]
 

Constraints:

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
Only one valid answer exists.
 */

//understanding question first
//! Problem Explanation:
// You have a list of numbers, and you need to find two numbers in the list
// that add up to a specific target number. Each number in the list can only
// be used once, and you need to find the indices (positions) of these two numbers.

//! Why Choose This Solution:
//  use this solution because it efficiently finds the two numbers that add up
// to the target number without having to check all possible combinations.
// By using a technique called the //? two-pointer technique,
// we can solve the problem in a single pass through the list,
// which makes it faster and more efficient.

///*  Solution
class Solution {
  List<int> twoSum(List<int> nums, int target) {
    // Create a map to store the complement of each element and its index
    var comMap = <int, int>{};
    for (var i = 0; i < nums.length; i++) {
      var complement = target - nums[i];
      // If the complement exists in the map, return its index along with the current index
      if (comMap.containsKey(complement)) {
        return [comMap[complement]!, i];
      }
      // Store the current element and its index in the map
      comMap[nums[i]] = i;
    }
    // No two elements sum up to the target
    return [];
  }
}
