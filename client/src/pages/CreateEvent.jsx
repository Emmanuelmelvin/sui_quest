import { useCurrentAccount } from "@mysten/dapp-kit";
import { useState } from "react";

const CreateEvent = () => {
  const account = useCurrentAccount();

  const [formData, setFormData] = useState({
    name: "",
    description: "",
    image: "",
    banner: "",
    website: "",
    start_time: "",
    end_time: "",
    location: "",
    category: "",
    tags: [],
    metadata_id: "", // Will be filled after saving to DB
    quest_previews: [
      {
        name: "",
        description: "",
        duration_sec: "",
        task_count: "",
      },
    ],
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;

    if (name === "tags") {
      setFormData((prev) => ({
        ...prev,
        tags: value.split(",").map((tag) => tag.trim()),
      }));
    } else {
      setFormData((prev) => ({
        ...prev,
        [name]: value,
      }));
    }
  };

  const handleQuestChange = (index, e) => {
    const { name, value } = e.target;
    const updatedQuests = [...formData.quest_previews];
    updatedQuests[index][name] = value;
    setFormData((prev) => ({
      ...prev,
      quest_previews: updatedQuests,
    }));
  };

  const addQuest = () => {
    if (formData.quest_previews.length >= 5) return;
    setFormData((prev) => ({
      ...prev,
      quest_previews: [
        ...prev.quest_previews,
        {
          name: "",
          description: "",
          duration_sec: "",
          task_count: "",
        },
      ],
    }));
  };

  const removeQuest = (index) => {
    const updatedQuests = [...formData.quest_previews];
    updatedQuests.splice(index, 1);
    setFormData((prev) => ({
      ...prev,
      quest_previews: updatedQuests,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const eventPayload = {
      ...formData,
      organizer: account?.address || "unknown",
    };

    console.log("📝 Submitting to backend for metadata_id:", eventPayload);

    // 1. Save to DB (off-chain)
    // const metadataId = await saveEventToDatabase(eventPayload);

    // 2. Call Move contract using the returned metadataId
    // createEvent({ name: formData.name, metadata_id: metadataId });
  };

  return (
    <div style={{ maxWidth: "800px", margin: "0 auto", padding: "24px" }}>
      <h2>Create a New Event</h2>

      <form onSubmit={handleSubmit}>
        <label>
          Event Name:
          <input name="name" value={formData.name} onChange={handleInputChange} required />
        </label>

        <label>
          Description:
          <textarea name="description" value={formData.description} onChange={handleInputChange} required />
        </label>

        <label>
          Image URL:
          <input name="image" value={formData.image} onChange={handleInputChange} />
        </label>

        <label>
          Banner URL:
          <input name="banner" value={formData.banner} onChange={handleInputChange} />
        </label>

        <label>
          Website URL:
          <input name="website" value={formData.website} onChange={handleInputChange} />
        </label>

        <label>
          Start Time:
          <input type="datetime-local" name="start_time" value={formData.start_time} onChange={handleInputChange} required />
        </label>

        <label>
          End Time:
          <input type="datetime-local" name="end_time" value={formData.end_time} onChange={handleInputChange} required />
        </label>

        <label>
          Location:
          <input name="location" value={formData.location} onChange={handleInputChange} />
        </label>

        <label>
          Category:
          <select name="category" value={formData.category} onChange={handleInputChange}>
            <option value="">Select</option>
            <option value="Education">Education</option>
            <option value="Campaign">Campaign</option>
            <option value="Workshop">Workshop</option>
            <option value="Hackathon">Hackathon</option>
          </select>
        </label>

        <label>
          Tags (comma-separated):
          <input name="tags" value={formData.tags.join(", ")} onChange={handleInputChange} />
        </label>

        <h3>Quests</h3>
        {formData.quest_previews.map((quest, idx) => (
          <div key={idx} style={{ border: "1px solid #ccc", padding: "10px", marginBottom: "10px" }}>
            <label>
              Quest Name:
              <input
                name="name"
                value={quest.name}
                onChange={(e) => handleQuestChange(idx, e)}
                required
              />
            </label>
            <label>
              Description:
              <input
                name="description"
                value={quest.description}
                onChange={(e) => handleQuestChange(idx, e)}
              />
            </label>
            <label>
              Duration (sec):
              <input
                type="number"
                name="duration_sec"
                value={quest.duration_sec}
                onChange={(e) => handleQuestChange(idx, e)}
              />
            </label>
            <label>
              Task Count:
              <input
                type="number"
                name="task_count"
                value={quest.task_count}
                onChange={(e) => handleQuestChange(idx, e)}
              />
            </label>
            {formData.quest_previews.length > 1 && (
              <button type="button" onClick={() => removeQuest(idx)} style={{ marginTop: "8px" }}>
                Remove Quest
              </button>
            )}
          </div>
        ))}

        {formData.quest_previews.length < 5 ? (
          <button type="button" onClick={addQuest}>
            Add Another Quest
          </button>
        ) : (
          <p style={{ color: "gray" }}>⚠️ You’ve reached the 5-quest limit.</p>
        )}

        {
          account? (
            <button type="submit" style={{ marginTop: "20px" }}>
              Create Event
            </button>
          ) : (
            <p style={{ color: "red" }}>Please connect your wallet to create an event.</p>
          )
        }
      </form>

      <div style={{ marginTop: 20, fontSize: 12, color: "gray" }}>
        Connected account: {account?.address || "No wallet connected"}
      </div>
    </div>
  );
};

export default CreateEvent;
