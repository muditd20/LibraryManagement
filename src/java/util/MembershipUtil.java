package util;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class MembershipUtil {
    public static String generateMembershipNo() {
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        int random = new Random().nextInt(9000) + 1000; // 4 digits
        return "LIB" + date + random;
    }
}
