from django.shortcuts import render_to_response

# Create your views here.
def home(request, template_name='home.html'):
    data = {
        'name': '<Your Name Here>'
    }

    return render_to_response(template_name,
                              data)
