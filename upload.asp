import os
import re

ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png', 'gif'}
UPLOAD_FOLDER = 'uploads/'

def allowed_file(filename):
    # Check if the file extension is in the allowed extensions
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def check_file_type(file):
    # Check if the file has a double extension or if it's a file without a filename
    if re.search(r'\.[^.]*\.[^.]*$', file.filename) or re.search(r'^\.[^.]+$', file.filename):
        return False
    return True

def rename_and_save_file(file):
    if file and allowed_file(file.filename) and check_file_type(file):
        # Rename file to a random string + the original extension
        filename = os.urandom(24).hex() + '.' + file.filename.rsplit('.', 1)[1]
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)
        # Change permissions of the file to prevent execution
        os.chmod(filepath, 0o644)
        return filename
    return None
