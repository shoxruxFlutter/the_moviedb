<!-- Your HTML file -->
<select id="selectOption">
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
</select>
<div id="resultContainer"></div>

<script>
    // JavaScript function to handle the AJAX request
    $(document).ready(function() {
        $('#selectOption').on('change', function() {
            var selectedValue = $(this).val();

            // AJAX request with POST method
            $.ajax({
                url: '/get-data',
                type: 'POST',
                data: {
                    id: selectedValue
                },
                dataType: 'json',
                success: function(data) {
                    // Update the resultContainer with the fetched data
                    var resultContainer = $('#resultContainer');
                    resultContainer.empty(); // Clear previous content
                    $.each(data, function(index, option) {
                        var optionElement = $('<p>').text(option.name);
                        resultContainer.append(optionElement);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });
</script>
