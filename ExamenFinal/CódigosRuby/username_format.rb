def username_format
    if username.present? and not username[0].match(/[a-zA-Z]/)
        errors.add(:username, "El nombre debe comenzar con una letra")
    end

    if username.present? and username.length > 10
        errors.add(:username, "El nombre debe tener como máximo 10 caracteres de largo")
    end
end