package com.aiphotostudio.template;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class TemplateController {

    private final TemplateService templateService;

    public TemplateController(TemplateService templateService) {
        this.templateService = templateService;
    }

    @GetMapping("/categories")
    public ResponseEntity<List<CategoryResponse>> categories() {
        return ResponseEntity.ok(templateService.listCategories());
    }

    @GetMapping("/templates")
    public ResponseEntity<List<TemplateResponse>> templates(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Boolean trending
    ) {
        return ResponseEntity.ok(templateService.listTemplates(category, trending));
    }

    @GetMapping("/templates/{id}")
    public ResponseEntity<TemplateResponse> template(@PathVariable("id") String id) {
        return ResponseEntity.ok(templateService.getTemplate(id));
    }
}
