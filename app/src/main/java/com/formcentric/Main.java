package com.formcentric;

import java.lang.management.ManagementFactory;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        System.out.println("Welcome to the Formcentric Java Base image.");
        System.out.println();

        String vendor = System.getProperty("java.vendor");

        System.out.println("  Java Version  : " + System.getProperty("java.version") + " (" + vendor + ")");
        System.out.println("  Java Home     : " + System.getProperty("java.home"));
        System.out.println("  Java Temp Dir : " + System.getProperty("java.io.tmpdir"));
        System.out.println();
        System.out.println("  User Name     : " + System.getProperty("user.name"));
        System.out.println("  Working Dir   : " + System.getProperty("user.dir"));
        System.out.println();

        // JVM arguments
        System.out.println("JVM Arguments");
        List<String> jvmArgs = ManagementFactory.getRuntimeMXBean().getInputArguments();
        if (jvmArgs.isEmpty()) {
            System.out.println("  - none -");
        } else {
            int i = 1;
            for (String entry : jvmArgs) {
                System.out.println("  (" + i++ + ") " + entry);
            }
        }
        System.out.println();

        // Command Line Arguments
        System.out.println("Command Line Arguments");
        if (args.length == 0) {
            System.out.println("  - none -");
        } else {
            int i = 1;
            for (String entry : args) {
                System.out.println("  (" + i++ + ") " + entry);
            }
        }
    }
}
