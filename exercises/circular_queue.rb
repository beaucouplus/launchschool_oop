# Your task is to write a CircularQueue class that implements a circular queue
# for arbitrary objects. The class should obtain the buffer size with an
# argument provided to CircularQueue::new, and should provide the following
# methods:

# enqueue to add an object to the queue
# # dequeue to remove (and return) the
# oldest object in the queue.
#  It should return nil if the queue is empty.
#  You  may assume that none of the values stored in the queue are nil
#  (however, nil may be used to designate empty spots in the buffer).

require 'pry'

class CircularQueue

  attr_reader :queue, :items_order, :empty_slots
  def initialize(size)
    @queue = Array.new(size)
    @items_order = []
    @available_slots = (0..(size - 1)).to_a
  end

  def enqueue(item)
    items_order << item
    queue[available_slot!] = item
  end

  def dequeue
    return nil if queue.all? { |value| value == nil }
    dequeued_item = items_order.shift
    dequeued_idx = queue.index(dequeued_item)
    available_slots << dequeued_idx
    queue[dequeued_idx] = nil
    dequeued_item
  end

  private

  def available_slot!
    available_slots.empty? ? queue.index(items_order.shift) : empty_slots.shift
  end
end



queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
