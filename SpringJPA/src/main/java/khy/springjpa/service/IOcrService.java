package khy.springjpa.service;

import java.io.IOException;

public interface IOcrService {

    // Detects text in the specified image.
    String detectText(String filePath) throws IOException;
}
