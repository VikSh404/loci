package com.redstack;
import java.io.*;
import java.util.*;

public class App {

  private static List objects = new ArrayList();
  private static boolean cont = true;
  private static String input;
  private static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

  public static void main(String[] args) throws Exception {
    System.out.println("Welcome to Memory Tool!");

    while (cont) {
      System.out.println(
        "\n\nI have " + objects.size() + " objects in use, about " +
        (objects.size() * 10) + " MB." +
        "\nWhat would you like me to do?\n" +
        "1. Create some objects\n" +
        "2. Remove some objects\n" +
        "0. Quit");
      input = in.readLine();
      if ((input != null) && (input.length() >= 1)) {
        if (input.startsWith("0")) cont = false;
        if (input.startsWith("1")) createObjects();
        if (input.startsWith("2")) removeObjects();
      }
    }

    System.out.println("Bye!");
  }

  private static void createObjects() {
    System.out.println("Creating objects...");
    for (int i = 0; i < 2; i++) {
       objects.add(new byte[10*1024*1024]);
     }
   }

   private static void removeObjects() {
     System.out.println("Removing objects...");
     int start = objects.size() - 1;
     int end = start - 2;
     for (int i = start; ((i >= 0) && (i > end)); i--) {
      objects.remove(i);
    }
  }
}