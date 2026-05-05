import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

public class Counter {
    private final AtomicInteger count = new AtomicInteger(0);
    private final Logger logger = Logger.getLogger(Counter.class.getName());

    public void increment() {
        int newValue = count.incrementAndGet();
        logger.info("Counter incremented to: " + newValue);
    }

    public int getValue() {
        return count.get();
    }

    public void reset() {
        int old = count.getAndSet(0);
        logger.info("Counter reset from " + old + " to 0");
    }

    // example
    public static void main(String[] args) {
        Counter counter = new Counter();
        counter.increment();
        counter.increment();
        System.out.println("Current value: " + counter.getValue());
        counter.reset();
        System.out.println("After reset: " + counter.getValue());
    }
}
