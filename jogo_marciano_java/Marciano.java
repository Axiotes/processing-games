import java.util.Random;
import java.util.Scanner;

public class Marciano {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        Game game = new Game();
        int option = 0;

        while (option != 2) {
            System.out.println("Seja bem vindo ao Jogo do Marciano, existem 100 árvores e o Marciano está escondido em uma delas! Você terá 7 tenativas para encontra-lo");
            System.out.println("------------------------------------");
            System.out.println("Recordes de tentativas usadas:");
            for (int i = 0; i < game.getRecords().length; i++) {
                int record = game.getRecords()[i];
                String position = i + 1 + "º:   ";

                if (record != 0) {
                    System.out.print(position + record + "\n");
                }
            }
            System.out.println("------------------------------------");
            System.out.println("Digite 1: INICIAR");
            System.out.println("Digite 2: SAIR");
            option = scan.nextInt();

            if (option == 2) break;

            game.initialize();

            while (0 < game.getAttempts()) {
                System.out.println("------------------------------------");
                System.out.println("Tentativas: " + game.getAttempts());
                System.out.println("Digite um número entre 1 e 100");
                int number = scan.nextInt();

                System.out.println("------------------------------------");
                if (game.attemptNumber(number)) break;

                if (0 == game.getAttempts()) {
                    System.out.println("------------------------------------");
                    System.out.println("Você Perdeu!!!");
                    System.out.println("O Marciano estava na árvore " + game.getMarciano());
                    System.out.println("------------------------------------");
                }
            }
        }

        System.out.println("Jogo Finalizado");
    }
}
