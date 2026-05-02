import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class PrimeFilter {
    public static void main(String[] args) {
        List<Integer> primes = IntStream.rangeClosed(2, 100)
            .filter(PrimeFilter::isPrime)
            .boxed()
            .collect(Collectors.toList());

        System.out.println(primes);
    }

    private static boolean isPrime(int n) {
        return IntStream.rangeClosed(2, (int) Math.sqrt(n))
            .allMatch(i -> n % i != 0);
    }
}
