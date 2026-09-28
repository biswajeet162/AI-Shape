package com.aiphotostudio.template;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.aiphotostudio.common.ApiException;
import com.aiphotostudio.common.GlobalExceptionHandler;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(controllers = TemplateController.class)
@Import(GlobalExceptionHandler.class)
class TemplateControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private TemplateService templateService;

    @Test
    void listsTemplates() throws Exception {
        when(templateService.listTemplates(null, null)).thenReturn(List.of(sample()));

        mockMvc.perform(get("/api/v1/templates"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("90s Retro"))
                .andExpect(jsonPath("$[0].slug").value("retro-90s"))
                .andExpect(jsonPath("$[0].prompt").doesNotExist());
    }

    @Test
    void getsTemplateById() throws Exception {
        when(templateService.getTemplate("retro-90s")).thenReturn(sample());

        mockMvc.perform(get("/api/v1/templates/retro-90s"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.category").value("Retro"));
    }

    @Test
    void listsCategories() throws Exception {
        when(templateService.listCategories()).thenReturn(List.of(
                new CategoryResponse(
                        UUID.fromString("11111111-1111-1111-1111-111111111001"),
                        "Retro",
                        "retro",
                        Instant.parse("2026-01-01T00:00:00Z")
                )
        ));

        mockMvc.perform(get("/api/v1/categories"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Retro"));
    }

    @Test
    void returnsNotFoundForMissingTemplate() throws Exception {
        when(templateService.getTemplate(any())).thenThrow(
                new ApiException("TEMPLATE_NOT_FOUND", "Style not found.", HttpStatus.NOT_FOUND)
        );

        mockMvc.perform(get("/api/v1/templates/missing"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.code").value("TEMPLATE_NOT_FOUND"));
    }

    @Test
    void filtersTrending() throws Exception {
        when(templateService.listTemplates(eq(null), eq(true))).thenReturn(List.of(sample()));

        mockMvc.perform(get("/api/v1/templates").param("trending", "true"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].trending").value(true));
    }

    private TemplateResponse sample() {
        return new TemplateResponse(
                UUID.fromString("22222222-2222-2222-2222-222222222001"),
                "90s Retro",
                "retro-90s",
                "Retro",
                "Give your portrait a nostalgic 1990s film photography look.",
                "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&q=80",
                true,
                Instant.parse("2026-01-01T00:00:00Z")
        );
    }
}
