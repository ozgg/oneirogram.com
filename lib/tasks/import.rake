# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :import do
  desc 'Import users from legacy YAML'
  task users: :environment do
    file_path = Rails.root.join('tmp/import/users.yml').to_s
    if File.exist? file_path
      attributes = %w[bot created_at email email_confirmed password_digest slug super_user updated_at]
      puts 'Importing legacy users...'
      File.open(file_path, 'r') do |file|
        YAML.safe_load(file).each_value do |data|
          print "\r#{data['uuid']} "
          data['slug'] = data['slug'].gsub(/^facebook/, 'fb').gsub(/^mail_ru/, 'vk').gsub(/^vkontakte/, 'vk')
          entity = User.find_or_initialize_by uuid: data['uuid']
          entity.assign_attributes(data.slice(*attributes))
          entity.save!
        end
        puts
      end
      puts "Done. We have #{User.count} users now"
    else
      puts "Cannot find file #{file_path}"
    end
  end

  desc 'Import sleep places from legacy YAML'
  task sleep_places: :environment do
    users_path = Rails.root.join('tmp/import/users.yml').to_s
    user_map = {}
    if File.exist? users_path
      puts 'Mapping legacy users...'
      File.open(users_path, 'r') do |file|
        YAML.safe_load(file).each do |user_id, data|
          print "\r#{data['uuid']} "
          user_map[user_id] = User.find_by(uuid: data['uuid'])&.id
        end
        puts
      end
      puts "Legacy users mapped. We have #{user_map.count} users in mapping"
    else
      puts "Cannot find file #{users_path}"
    end
    file_path = Rails.root.join('tmp/import/sleep_places.yml').to_s
    if File.exist? file_path
      puts 'Importing legacy sleep places...'
      File.open(file_path, 'r') do |file|
        YAML.safe_load(file).each_value do |data|
          print "\r#{data['user_id']}:#{data['name']} "
          entity = SleepPlace.find_or_initialize_by(user_id: user_map[data['user_id']], name: data['name'])
          entity.save!
        end
        puts
      end
      puts "Done. We have #{SleepPlace.count} sleep places now"
    else
      puts "Cannot find file #{file_path}"
    end
  end

  desc 'Import dreams from legacy YAML'
  task dreams: :environment do
    places_path = Rails.root.join('tmp/import/sleep_places.yml').to_s
    places_map = {}
    if File.exist? places_path
      puts 'Mapping legacy sleep places...'
      File.open(places_path, 'r') { |f| places_map = YAML.safe_load(f) }
      puts "Legacy places mapped. We have #{places_map.count} places in mapping"
    else
      puts "Cannot find file #{places_path}"
    end

    attributes = %w[body created_at lucidity privacy title updated_at]
    file_path = Rails.root.join('tmp/import/dreams.yml').to_s
    if File.exist? file_path
      puts 'Importing legacy dreams...'
      File.open(file_path, 'r') do |file|
        YAML.safe_load(file).each_value do |data|
          print "\r#{data['uuid']} "
          entity = Dream.find_or_initialize_by(uuid: data['uuid'])
          next if entity.id.present?
          entity.user_id = User.find_by(uuid: data['user_uuid'])
          if data.key?('sleep_place_id')
            criteria = {
              user_id: entity.user_id,
              name: places_map[data['sleep_place_id']]['name']
            }
            entity.sleep_place = SleepPlace.find_by(criteria)
          end
          entity.assign_attributes(data.slice(*attributes))
          entity.save!
        end
        puts
      end
      puts "Done. We have #{Dream.count} dreams now"
    else
      puts "Cannot find file #{file_path}"
    end
  end

  desc 'Import comments from legacy YAML'
  task comments: :environment do
    puts 'Not implemented yet'
  end

  desc 'Import generic dream images from legacy YAML'
  task patterns: :environment do
    puts 'Not implemented yet'
  end
end
# rubocop:enable Metrics/BlockLength
