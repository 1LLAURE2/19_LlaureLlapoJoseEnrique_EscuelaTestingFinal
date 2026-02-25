package user;

import com.intuit.karate.junit5.Karate;

public class UserRunner {
    @Karate.Test
    Karate testStore() {
        return Karate.run("user").relativeTo(getClass());
    }
}
