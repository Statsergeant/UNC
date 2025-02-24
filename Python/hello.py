from flask import Flask, request, redirect, render_template


app = Flask(__name__)

@app.route('/')
def home():
    return render_template('user.html')  # Passing a list

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 5000, debug=True)
