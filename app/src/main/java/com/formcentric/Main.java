package com.formcentric;

public class Main {
    public static void main(String[] args) {
        System.out.println("Welcome to Formcentric Java Base image.");
        System.out.println();

        String vendor = System.getProperty("java.vendor");

        System.out.println("  Java Version  : " + System.getProperty("java.version") + " (" + vendor + ")");
        System.out.println("  Java Temp Dir : " + System.getProperty("java.io.tmpdir"));
        System.out.println();
        System.out.println("  User Name     : " + System.getProperty("user.name"));
        System.out.println("  Working Dir   : " + System.getProperty("user.dir"));
    }
}
