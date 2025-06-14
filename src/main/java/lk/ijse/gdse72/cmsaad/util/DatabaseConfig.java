package lk.ijse.gdse72.cmsaad.util;

import org.apache.commons.dbcp2.BasicDataSource;

public class DatabaseConfig {
    private static final BasicDataSource basicDataSource = new BasicDataSource();

    static {
        try {
            basicDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
            basicDataSource.setUrl("jdbc:mysql://localhost:3306/cms");
            basicDataSource.setUsername("root");
            basicDataSource.setPassword("mysql");
            basicDataSource.setInitialSize(5);
            basicDataSource.setMaxTotal(10);
            basicDataSource.setMinIdle(2);
            basicDataSource.setMaxIdle(5);
            basicDataSource.setMaxWaitMillis(10000); // 10 seconds

            System.out.println("=== Database connection pool ==== initialized successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("=== Database connection pool ==== initialization failed.");
        }
    }
    public static BasicDataSource getDataSource() {
        return basicDataSource;
    }

    public static void closeDataSource() {
        try {
            basicDataSource.close();
            System.out.println("=== Database connection pool ==== closed successfully.");
        } catch (Exception e) {
            System.out.println("=== Database connection pool ==== failed to close.");
        }
    }

}
