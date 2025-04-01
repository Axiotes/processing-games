import java.util.Random;


public class Game {
    private Random random = new Random();
    private int attempts, marciano, initialAttempt = 7;
    private int[] records = new int[3];

    public int getAttempts() {
        return attempts;
    }

    public int getMarciano() {
        return marciano;
    }

    public int[] getRecords() {
        return records;
    }

    public void initialize() {
        this.marciano = this.random.nextInt(99) + 1;
        this.attempts = initialAttempt;

        System.out.println(this.marciano);
    }

    public boolean attemptNumber(int number) {
        if (!checkNumber(number)) return false;

        this.attempts -= 1;

        if (number < this.marciano) {
            System.out.println("O Marciano está em uma árvore mais alta");
            return false;
        }

        if (number > this.marciano) {
            System.out.println("O Marciano está em uma árvore mais baixa");
            return false;
        }

        System.out.println("Você Acertou!!!");
        this.sortRecord();
        return true;
    }

    private boolean checkNumber(int number) {
        if (number >= 0 && number <= 100) return true;

        System.out.println("Número Inválido!");
        return false;
    }

    private void sortRecord() {
        int attemptsUsed = this.initialAttempt - this.attempts;

        for (int i = 0; i < records.length; i++) {
            int record = records[i];
            if (attemptsUsed < record || record == 0) {
                for (int j = records.length - 1; j > i; j--) {
                    records[j] = records[j-1];
                }
                records[i] = attemptsUsed;
                break;
            }
        }
    }
}
